{ pkgs, ... }:

{
  home.packages = with pkgs; [
    projecteur # logitech spotlight app
  ];
}
