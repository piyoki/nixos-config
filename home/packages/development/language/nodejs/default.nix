{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs_latest #
    typescript # Superset of JavaScript that compiles to clean JavaScript output
    yarn

    nodePackages.prettier # Opinionated code formatter
    nodePackages.vercel # Vercel CLI
    nodePackages_latest.vscode-json-languageserver # JSON language server
    prisma # Next-generation ORM for Node.js and TypeScript
  ];
}
