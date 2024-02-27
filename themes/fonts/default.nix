_:

# References: https://nixos.wiki/wiki/Fonts
{
  imports = [
    ./chinese-fonts.nix
    ./common-fonts.nix
    ./custom-fonts.nix
    ./japanese-fonts.nix
    ./icons.nix
  ];

  # Enable fonts
  fonts = {
    fontDir.enable = true;
  };
}
