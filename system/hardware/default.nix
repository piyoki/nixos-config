{ pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./audio.nix
    ./usb.nix
  ];
}

