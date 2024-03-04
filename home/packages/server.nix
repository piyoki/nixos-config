{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # maintenance essentials
    bat
    delta
    jq
    lazygit
    neovim
    ncdu
    vivid
    zoxide
    trash-cli
    unzip
    zip
  ];
}
