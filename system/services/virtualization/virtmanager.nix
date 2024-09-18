_:

# References:
# https://nixos.wiki/wiki/Virt-manager
# https://www.surlyjake.com/blog/2020/10/09/ubuntu-cloud-images-in-libvirt-and-virt-manager/

{
  # enable virtmanager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # trust the default bridge interface
  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
