{ pkgs, ... }:

{
  imports = [
    ./languages
  ];

  home.packages = with pkgs; [
    bat
    cmake
    ctags
    delta
    gcc
    github-cli
    gnumake
    httpie
    jq
    lazygit
    luajit
    shfmt
    stylua
    tree-sitter
    litecli # Command-line interface for SQLite
    insomnia # The most intuitive cross-platform REST API Client
    git-trim # Automatically trims your branches whose tracking remote refs are merged or gone
    hugo # A fast and modern static website engine
    pre-commit # A framework for managing and maintaining multi-language pre-commit hooks
  ];
}
