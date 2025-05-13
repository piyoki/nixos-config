{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    inputs.neovim-nightly-overlay.packages.${system}.default
    notepadqq
  ];
}
