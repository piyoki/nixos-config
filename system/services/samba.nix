{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];
}

