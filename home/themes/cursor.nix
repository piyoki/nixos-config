{ pkgs, ... }:

# Ref: https://github.com/hyprwm/Hyprland/issues/1577
# Command to set:
# hyprctl setcursor Bibata-Modern-Ice 46
{
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
}
