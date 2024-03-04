_:

{
  imports = [
    # ./cifs-mount.nix
    ./fish.nix
    ./windowmanager.nix
    ./gnupg
    ./powermanagement
    # ./greetd.nix
    # ./displaymanager.nix
    ./xdg-portal.nix
    ./flatpak.nix
    ./thunar.nix
    # ./virtualization.nix
    # ./docker.nix
    # ./printer.nix
    ./openssh
    ./gnome-keyring.nix
    ./zramd.nix
  ];
}
