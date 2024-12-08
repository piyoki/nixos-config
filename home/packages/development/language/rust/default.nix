{ pkgs, inputs, system, ... }:

# References:
# https://github.com/nix-community/fenix

{
  home.packages = [
    inputs.rust-nightly-overlay.packages.${system}.latest.toolchain # derivation with all the Rust components; including rust-analyzer (LSP)
    pkgs.uv # Extremely fast Python package installer and resolver, written in Rust
  ];
}
