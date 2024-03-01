{ pkgs, ... }:

{
  home.packages = with pkgs; [
    flat-remix-gtk
    tokyonight-gtk-theme
  ];

  gtk = {
    enable = true;
    theme = {
      # package = pkgs.flat-remix-gtk;
      # name = "Flat-Remix-GTK-Grey-Darkest";
      package = pkgs.tokyonight-gtk-theme;
      name = "Tokyonight-Dark";
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
