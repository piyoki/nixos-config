{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blueberry
  ];

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true; # enable support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
}
