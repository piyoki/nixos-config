_:

# References:
# https://nixos.wiki/wiki/Virt-manager
# https://nixos.wiki/wiki/Docker
{
  # enable virtmanager
  virtualisation.libvirtd.enable = false;
  programs.virt-manager.enable = false;

  # enable docker
  virtualisation.docker.enable = false;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
