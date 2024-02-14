_:

{
  imports = [
    ./displaymanager.nix
    ./gnupg.nix
    ./powermanagement.nix
    ./xdg-portal.nix
    ./flatpak.nix
    ./thunar.nix
    # ./printer.nix
  ];

  services = {
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
