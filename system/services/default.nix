{ pkgs, ... }:

{
  imports = [
    ./displaymanager.nix
    ./gnupg.nix
    ./samba.nix
    ./powermanagement.nix
    ./xdg-portal.nix
    # ./printer.nix
  ];

  services = {
    # gvfs
    gvfs.enable = true;
    # openssh daemon
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false; # disable SSH password log in
    };
  };

  programs = {
    fish.enable = true;
  };

  zramSwap.enable = true;
  virtualisation.docker.enable = true;
}
