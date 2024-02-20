_:

{
  imports = [
    ./encryption
    ./dconf
    ./mpd
    ./systemd
    ./xdg
  ];

  # disable dunst systemd service, controlled it by windowmanager instead
  services.dunst.enable = false;
}
