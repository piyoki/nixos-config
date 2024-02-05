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
      noto-fonts-cjk
      noto-fonts-emoji
      source-code-pro
    ];
  };
}



