{ pkgs, ... }:

{
  # Enable fonts
  fonts = {
    packages = with pkgs; [
      material-design-icons
    ];
  };
}
