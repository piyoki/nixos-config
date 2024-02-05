{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodePackages.prettier
    nodejs_latest
    yarn
  ];
}


