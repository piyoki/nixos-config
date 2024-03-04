{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    delta
    jq
    lazygit
    neovim
    vivid
    zoxide
    trash-cli
    unzip
    zip
  ];
}
