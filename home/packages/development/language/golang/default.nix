{ pkgs, ... }:

{
  home.packages = with pkgs; [
    golangci-lint # Fast linters Runner for Go
    protobuf # Protocol Buffers - Google's data interchange format
    protoc-gen-go # Go support for Google's protocol buffers
    protoc-gen-go-grpc # Go support for gRPC
  ];

  programs.go.env = {
    GONOSUMDB = "gitea.hikarilab.me/*";
    GOPRIVATE = "gitea.hikarilab.me/*";
    GOPROXY = "direct";
  };
}
