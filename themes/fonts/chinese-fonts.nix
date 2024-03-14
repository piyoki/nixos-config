{ pkgs, ... }:

{
  # Enable fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk
      source-han-sans
      source-han-serif
    ];
  };
}
