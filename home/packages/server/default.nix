{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    delta
    jq
    lazygit
    vivid
    zoxide
  ];
}
