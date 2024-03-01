_:

{
  imports = [
    ./encryption
    ./dconf
    ./mpd
    ./systemd
    ./xdg
    ./wayland-session
  ];

  # disable dunst systemd service, controlled it by windowmanager instead
  services.dunst.enable = false;
}
