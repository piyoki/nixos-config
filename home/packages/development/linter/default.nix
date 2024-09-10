{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tflint # Terraform linter focused on possible errors, best practices, and so on
    golangci-lint-langserver # Language server for golangci-lint
    actionlint # GitHub Actions linter
  ];
}
