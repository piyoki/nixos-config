{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    polkit # policy daemon
  ];

  security.polkit.enable = true;
  security.polkit.debug = true;
}
