{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # networking
    dnsutils
  ];
}
