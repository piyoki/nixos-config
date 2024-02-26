{ pkgs, ... }:

{
  # Enable fonts
  fonts = {
    packages = with pkgs; [
      cantarell-fonts
      fira-code
      fira-code-symbols
      jetbrains-mono
      nerdfonts
      noto-fonts
      noto-fonts-emoji
      source-code-pro

      # overrides
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [
          "Noto Color Emoji"
        ];
        serif = [
          "GenSekiGothic TW B"
          "Sarasa Gothic TC"
          "Noto Serif CJK TC"
          "Source Han Serif TC"
        ];
        sansSerif = [
          "GenSekiGothic TW B"
          "Sarasa Gothic TC"
          "Noto Sans CJK TC"
          "Source Han Sans TC"
        ];
      };
    };
  };
}
