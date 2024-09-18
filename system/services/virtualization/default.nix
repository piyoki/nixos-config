_:

# References:
# https://nixos.wiki/wiki/Virt-manager
{
  # enable virtmanager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
