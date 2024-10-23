{ pkgs, ... }:

{
  # Enable fonts
  fonts = {
    packages = with pkgs; [
      cantarell-fonts
      maple-mono
      maple-mono-NF
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      source-code-pro

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix
      (nerdfonts.override {
        fonts = [
          # symbols icon only
          "NerdFontsSymbolsOnly"
          # Characters
          "FiraCode"
          "JetBrainsMono"
        ];
      })
    ];
  };
}
