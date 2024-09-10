{ pkgs, ... }:

{
  home.packages = with pkgs; [
    stylua # A Lua code formatter
    luajit # Just-In-Time Compiler for Lua
    tree-sitter # An incremental parsing system
  ];
}
