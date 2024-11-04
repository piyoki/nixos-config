{ pkgs, ... }:

{
  # Enable fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-sans
      source-han-sans
      source-han-serif
      wqy_zenhei
    ];
  };
}
