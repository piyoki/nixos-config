{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blueberry
  ];

  # Enable bluetooth
  hardware.bluetooth.enable = true; # enable support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
}
