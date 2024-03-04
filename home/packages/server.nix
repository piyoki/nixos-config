{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    delta
    jq
    lazygit
    vivid
    zoxide
    trash-cli
    unzip
    zip
  ];
}
