{ inputs, system, ... }:

# References:
# https://github.com/nix-community/fenix

{
  home.packages = with inputs.rust-nightly-overlay.packages.${system}.latest; [
    cargo # Downloads your Rust project's dependencies and builds your project
    rustc # Safe, concurrent, practical language (wrapper script)
    rustfmt # Tool for formatting Rust code according to style guidelines
  ];
}
