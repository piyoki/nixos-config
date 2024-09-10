{ pkgs, ... }:

{
  home.packages = with pkgs; [
    golangci-lint # Fast linters Runner for Go
  ];
}
