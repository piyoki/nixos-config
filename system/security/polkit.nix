{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.polkit-kde-agent-1
  ];

  # policy daemon
  security.polkit = {
    enable = true;
    debug = true;
  };
}
