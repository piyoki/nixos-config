{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blueberry
  ];

  # Enable bluetooth
  hardware.bluetooth.enable = false; # enable support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot
}
