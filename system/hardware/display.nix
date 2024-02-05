{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ddcutil
  ];
}

