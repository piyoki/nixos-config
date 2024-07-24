{ lib, ... }:

# References:
# https://nixos.wiki/wiki/Laptop
# https://nixos.wiki/wiki/Power_Management
# https://wiki.archlinux.org/title/Power_management
{
  # default power management settings
  # powerManagement = {
  #   enable = true;
  #   cpuFreqGovernor = lib.mkDefault "powersave";
  # };

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
  };

  # auto-cpufreq settings
  programs.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        energy_performance_preference = "power";
        turbo = "never";

        scaling_min_freq = lib.mkDefault "400000"; # 400 MHz
        scaling_max_freq = lib.mkDefault "1400000"; # 1400 MHz, or 1.4 GHz
      };

      charger = {
        governor = "performance";
        turbo = "auto";
        energy_performance_preference = "performance";
      };
    };
  };
}
