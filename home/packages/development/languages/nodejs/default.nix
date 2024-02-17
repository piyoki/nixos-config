{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_latest
    yarn

    nodePackages.prettier
    nodePackages.vercel
  ];
}
