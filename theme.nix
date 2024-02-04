{ pkgs, ... }:

{
  nixpkgs = {
    config.qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = {
        package = with pkgs; [ adwaita-qt ];
        name = "adwaita-dark";
      };
    };
  };
}
