{ user, ...}:

{
  # dconf configuration options
  home-manager.users.${user}.dconf = {
    enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
      settings."org/gnome/desktop/interface".default-web-browser = "org.qutebrowser.qutebrowser.desktop";
  };
}

