_:

{
  # dconf configuration options
  dconf = {
    enable = true;
    settings = {
      # gtk specific
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        default-web-browser = "org.qutebrowser.qutebrowser.desktop";
      };

      # virt-manager specific
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}
