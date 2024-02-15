_:

{
  # dconf configuration options
  dconf = {
    enable = true;
    # gtk specific
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/desktop/interface".default-web-browser = "org.qutebrowser.qutebrowser.desktop";

    # virt-manager specific
    settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}
