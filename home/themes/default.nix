{ pkgs, ... }:

{
  imports = [
    ./fonts.nix
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      name = "Cantarell Regular";
      size = 12;
    };
  };
}

