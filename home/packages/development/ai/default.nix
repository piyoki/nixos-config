{ pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code # AI assistant CLI
  ];
}
