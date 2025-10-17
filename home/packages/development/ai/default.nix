{ pkgs, ... }:

{
  home.packages = with pkgs; [
    claude-code # AI assistant CLI
    codex # Lightweight coding agent that runs in your terminal
  ];
}
