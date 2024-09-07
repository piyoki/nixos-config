{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustc # Safe, concurrent, practical language (wrapper script)
    cargo # Downloads your Rust project's dependencies and builds your project
    rustfmt # Tool for formatting Rust code according to style guidelines
  ];
}
