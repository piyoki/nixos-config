{ pkgs, ... }:

{
  # Enable fonts
  fonts = {
    packages = with pkgs; [
      source-han-sans-japanese
      source-han-serif-japanese
    ];
  };
}
