{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    notepadqq
  ];
}
