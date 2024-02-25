{ pkgs, ... }:

{
  # Enable fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk
      sarasa-gothic
      source-han-sans
      source-han-serif
    ];
  };
}
