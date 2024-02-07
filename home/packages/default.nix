{ ... }:

{
  imports = [
    ./development
    ./devops
    ./encryption
    ./fonts
    ./latest # latest packages directly compiled from source code (flake inputs)
    ./monitoring
    ./networking
    ./peripherals
    ./windowmanager/hyprland
  ];
}
