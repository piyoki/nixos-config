{ user, ...}:

{
  # dconf configuration options
  dconf = {
    enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
      settings."org/gnome/desktop/interface".default-web-browser = "org.qutebrowser.qutebrowser.desktop";
  };
}

