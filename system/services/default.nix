_:

{
  imports = [
    # ./cifs-mount.nix
    ./dconf.nix
    ./windowmanager.nix
    ./gnupg.nix
    ./powermanagement.nix
    ./xdg-portal.nix
    ./flatpak.nix
    ./thunar.nix
    ./virtualization.nix
    # ./displaymanager.nix
    # ./printer.nix
  ];

  services = {
    # openssh daemon
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false; # disable SSH password log in
    };
  };

  # fish
  programs.fish.enable = true;

  # zramd
  zramSwap.enable = true;
}
