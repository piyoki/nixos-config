{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ccid
    gnupg
    pcsctools
  ];
}
