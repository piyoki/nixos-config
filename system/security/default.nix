{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    polkit # policy daemon
    polkit-kde-agent
  ];

  security = {
    polkit.enable = true;
    polkit.debug = true;

    # make swaylock unlocks with correct password
    pam.services.swaylock = { };
  };
}
