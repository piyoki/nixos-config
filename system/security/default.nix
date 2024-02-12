{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    polkit # policy daemon
    polkit-kde-agent
  ];

  security.polkit.enable = true;
  security.polkit.debug = true;

  # make swaylock unlocks with correct password
  security.pam.services.swaylock = { };
}
