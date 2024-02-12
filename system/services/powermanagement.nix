{ lib, user, ... }:

# References:
# https://nixos.wiki/wiki/Laptop
# https://nixos.wiki/wiki/Power_Management
{
  # default power management settings
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };

  services = {
    # prevents overheating on Intel CPUs
    thermald.enable = true;

    # power-saving setttings
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;

        # (optional) helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

        # x1-carbon specific settings
        # Reference: https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Carbon_(Gen_10)#Powersaving
        RUNTIME_PM_DENYLIST="08:00.0";
      };
    };

    # auto-cpufreq settings
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };

  # power resume hooks
  systemd.services.waybars = {
    description = "relaunch waybars when power resumes";
    wantedBy = [ "post-resume.target" ];
    after = [ "post-resume.target" ];
    script = ''
      set -eux
      /run/current-system/sw/bin/pkill .waybar-wrapped
    '';
    serviceConfig = {
      Type = "oneshot";
      User = user;
    };
  };
}

