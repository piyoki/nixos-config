{ pkgs, ... }:

{
  imports = [
    ./packages
    ./services
    ./networking
    ./hardware
  ];
}
