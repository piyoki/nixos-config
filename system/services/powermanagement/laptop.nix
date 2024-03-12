{ pkgs, ... }:

# References:
# https://nixos.wiki/wiki/Laptop
# https://nixos.wiki/wiki/Power_Management
# https://wiki.archlinux.org/title/Power_management
let
  swBin = "/run/current-system/sw/bin";
in
{
  # systemd unit
  systemd.services = {
    # set battery charge max and min threshold
    "battery_charge_threshold" = {
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
