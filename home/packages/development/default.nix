{ inputs, pkgs, system, ... }:

# References:
# # https://github.com/ryan4yin/nix-config/blob/main/home/base/tui/editors/packages.nix

{
  imports = [
    ./language
    ./linter
    ./lsp
  ];

  home.packages = with pkgs; [
    bat # A cat(1) clone with wings
    ctags # Generates an index (or tag) file of language objects found in source files
    delta # A viewer for git and diff output
    gcc # The GNU Compiler Collection
    github-cli # GitHub’s official command line tool
    gnumake # The GNU version of the 'make' utility
    httpie # A command line HTTP client
    xh # Friendly and fast tool for sending HTTP requests
    jq # A lightweight and flexible command-line JSON processor
    lazygit # A simple terminal UI for git commands
    litecli # Command-line interface for SQLite
    insomnia # The most intuitive cross-platform REST API Client
    git-trim # Automatically trims your branches whose tracking remote refs are merged or gone
    hugo # A fast and modern static website engine
    pre-commit # A framework for managing and maintaining multi-language pre-commit hooks
    inputs.nur.packages.${system}.gitmux # Git in your tmux status bar
    oha # HTTP load generator inspired by rakyll/hey with tui animation
  ];
}
