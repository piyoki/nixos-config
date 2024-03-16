{ inputs, pkgs, system, ... }:

{
  home.packages = with pkgs; [
    neovim
    inputs.neovim-nightly-overlay.packages.${system}.neovim
    notepadqq
  ];
}
