{ pkgs, user, ... }:

# Reference: https://nixos.wiki/wiki/Flatpak
{
  services.flatpak.enable = true;

  users = {
    users.${user} = {
      packages = with pkgs; [ flatpak ];
    };
  };
}
