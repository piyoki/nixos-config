{ pkgs, ... }:

{
  imports = [
    ./languages
  ];

  home.packages = with pkgs; [
    bat
    cmake
    delta
    gcc
    git
    github-cli
    gnumake
    httpie
    jq
    lazygit
    luajit
    shfmt
    stylua
    tree-sitter
  ];
}
