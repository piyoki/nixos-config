_:

# References: https://nixos.wiki/wiki/Fonts
{
  imports = [
    ./bindfs.nix
    ./chinese-fonts.nix
    ./common-fonts.nix
    ./custom-fonts.nix
    ./fontconfig.nix
    ./japanese-fonts.nix
    ./icons.nix
  ];

  # Enable fonts
  fonts = {
    fontDir.enable = true;
  };
}
