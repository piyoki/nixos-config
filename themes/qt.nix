{ pkgs, ... }:

{
  nixpkgs = {
    config.qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = {
        package = with pkgs; [ adwaita-qt adwaita-qt6 gnome.adwaita-icon-theme ];
        name = "adwaita-dark";
      };
    };
  };
}
