{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_latest #
    typescript # Superset of JavaScript that compiles to clean JavaScript output
    yarn

    nodePackages.prettier # Opinionated code formatter
    nodePackages.vercel # Vercel CLI
  ];
}
