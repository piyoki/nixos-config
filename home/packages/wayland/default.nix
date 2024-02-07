{ inputs, system, pkgs, ... }:

{
  home.packages = with pkgs; [
    wdisplays
    wl-clipboard
    # inputs.nixpkgs-wayland."${pkgs.system}".nixpkgs-wayland
  ];
}
