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

    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [
          "Noto Color Emoji"
        ];
        serif = [
          "GenSekiGothic TW B"
          "Noto Serif CJK TC"
          "Source Han Serif TC"
        ];
        sansSerif = [
          "GenSekiGothic TW B"
          "Noto Sans CJK TC"
          "Source Han Sans TC"
        ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "Noto Color Emoji"
        ];
      };
    };
  };
}
