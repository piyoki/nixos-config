{ pkgs, ... }:

{
  home.packages = with pkgs; [
    golangci-lint # Fast linters Runner for Go
  ];

  programs.go.env = {
    GONOSUMDB = "gitea.hikarilab.me/*";
    GOPRIVATE = "gitea.hikarilab.me/*";
    GOPROXY = "direct";
  };
}
