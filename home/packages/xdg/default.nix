{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    xdg-utils
    xdg-user-dirs # run: xdg-user-dirs-update
    inputs.nixpkgs-wayland.packages.${system}.waybar
  ];
}
