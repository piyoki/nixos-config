{ pkgs, ... }:

{
  home.packages = with pkgs; [
    blueberry
  ];
}
