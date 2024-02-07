{ pkgs, ... }:

{
  imports = [
    ./hardware
    ./networking
    ./packages
    ./services
    ./users
  ];
}
