_:

# References:
# https://nixos.wiki/wiki/VirtualBox
{
  # enable VirtualBox
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
    guest.clipboard = true;
  };
}
