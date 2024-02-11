{ ... }:

{
  imports = [
    ./chinese-fonts.nix
    ./common-fonts.nix
    ./japanese-fonts.nix
    ./icons.nix
  ];

  # Enable fonts
  fonts = {
    fontDir.enable = true;
  };
}
