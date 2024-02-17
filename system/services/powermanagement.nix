{ pkgs, lib, ... }:

# References:
# https://nixos.wiki/wiki/Laptop
# https://nixos.wiki/wiki/Power_Management
# https://wiki.archlinux.org/title/Power_management
let
  swBin = "/run/current-system/sw/bin";
in
{
  # default power management settings
  powerManagement = {
    enable = true;
    cpuFreqGovernor = lib.mkDefault "powersave";
  };

  services = {
    # power-saving setttings
    # tlp = {
    #   enable = true;
    #   settings = {
    #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
    #     CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    #     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    #     CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

    #     CPU_MIN_PERF_ON_AC = 0;
    #     CPU_MAX_PERF_ON_AC = 100;
    #     CPU_MIN_PERF_ON_BAT = 0;
    #     CPU_MAX_PERF_ON_BAT = 60;

    #     # helps save long term battery health
    #     START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
    #     STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
    #   };
    # };

    # prevents overheating on Intel CPUs
    thermald.enable = true;

    # auto-cpufreq settings
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          energy_performance_preference = "power";
          turbo = "never";
          scaling_min_freq = "400000"; # 400 MHz
          scaling_max_freq = "1200000"; # 1200 MHz, or 1.2 GHz
        };
        charger = {
          governor = "performance";
          turbo = "auto";
          energy_performance_preference = "performance";
        };
      };
    };

  };

  # systemd unit
  # set battery charge max and min threshold
  systemd.services."battery_charge_threshold" = {
    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    description = "Set the battery charge threshold";
    serviceConfig = {
      ExecStart = "${pkgs.writeShellScript "lockscreen" ''
        set -eux
        ${swBin}/echo 0 > /sys/class/power_supply/BAT0/charge_control_start_threshold
        ${swBin}/echo 80 > /sys/class/power_supply/BAT0/charge_control_end_threshold
      ''}";
      Type = "oneshot";
      Environment = [
        "PATH=$PATH:${swBin}"
      ];
    };
  };

  # x1-carbon specific settings
  # Reference: https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Carbon_(Gen_10)#Powersaving
  # Lenovo supports 'platform-profiles' on newer kernels which can rather dramatically improve performance by decreasing throttling, or greatly improve battery life and thermals by lowering the CPU's power limit. These modes can result in over a 100% increase or decrease in CPU power draw. The default mode is "balanced" however users can switch between these modes using the following keyboard shortcuts:
  # The currently active mode can be checked with the following command:
  # Fn+l - Low-power mode
  # Fn+m - Balanced mode (aka Medium)
  # Fn+h - Performance mode (aka High)
  # cat /sys/firmware/acpi/platform_profile_choices
  # cat /sys/firmware/acpi/platform_profile
}
