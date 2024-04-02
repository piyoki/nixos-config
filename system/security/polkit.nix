{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    polkit # policy daemon
    polkit-kde-agent
  ];

  security.polkit = {
    enable = true;
    debug = true;
  };
}
