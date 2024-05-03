{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    polkit-kde-agent
  ];

  # policy daemon
  security.polkit = {
    enable = true;
    debug = true;
  };
}
