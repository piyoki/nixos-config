{ pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    claude-code # AI assistant CLI
    codex # Lightweight coding agent that runs in your terminal
    github-copilot-cli # GitHub Copilot CLI
  ];
}
