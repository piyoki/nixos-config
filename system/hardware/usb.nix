{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    usbutils # lsusb
    lm_sensors # sensors
    pciutils # lspci
  ];
}

