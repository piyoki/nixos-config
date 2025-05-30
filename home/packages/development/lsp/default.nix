{ pkgs, ... }:

# Reference
# https://github.com/ryan4yin/nix-config/blob/main/home/base/tui/editors/neovim/nvim/lua/plugins/mason.lua
# https://github.com/ryan4yin/nix-config/blob/main/home/base/tui/editors/packages.nix

{
  home.packages = with pkgs; [
    ansible-language-server # Ansible language server
    bash-language-server # Bash language server
    buf # Language server for protocol buffers
    clang-tools # Clang tools and libraries
    cmake-language-server # CMake language server
    docker-compose-language-service # Docker Compose language server
    dockerfile-language-server-nodejs # Dockerfile language server
    emmet-ls # Emmet support based on LSP
    gopls # Official language server for the Go language
    jdt-language-server # Java language server
    lua-language-server # Lua language server
    marksman # Language Server for Markdown
    nixd # Language server for Nix
    nodePackages_latest.graphql-language-service-cli # An interface for building GraphQL language services for IDEs
    nodePackages_latest.vscode-json-languageserver # JSON language server
    nodePackages_latest.vscode-langservers-extracted # HTML/CSS/JSON/ESLint language servers extracted from VSCode
    pyright # Python language server
    sqls # SQL language server written in Go
    tailwindcss-language-server # Tailwind CSS language server
    terraform-ls # Terraform Language Server (official)
    typescript-language-server # Language Server Protocol implementation for TypeScript using tsserver
    yaml-language-server # Language Server for YAML files
  ];
}
