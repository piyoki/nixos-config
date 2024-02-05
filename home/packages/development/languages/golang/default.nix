{ pkgs, ... }:

{
  home.packages = with pkgs; [
    golangci-lint
    gopls
  ];
}



