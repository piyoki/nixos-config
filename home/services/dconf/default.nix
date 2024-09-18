_:

{
  imports = [
    ./gtk.nix
    ./virtmanager.nix
  ];

  # enable dconf
  dconf.enable = true;
}
