_:

{
  imports = [
    # ./cifs-mount.nix
    # ./displaymanager.nix
    # ./docker.nix
    ./podman.nix
    ./greetd.nix
    # ./virtualization.nix
    ./btrfs.nix
    ./fish.nix
    ./flatpak.nix
    ./gnome-keyring.nix
    ./gnupg
    ./openssh
    ./powermanagement
    ./printer.nix
    ./rclone.nix
    ./thunar.nix
    ./windowmanager
    ./xdg-portal.nix
    ./zramd.nix
  ];
}
