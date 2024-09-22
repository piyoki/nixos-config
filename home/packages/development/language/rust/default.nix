{ inputs, system, ... }:

# References:
# https://github.com/nix-community/fenix

{
  home.packages = with inputs.rust-nightly-overlay.packages.${system}.latest; [
    toolchain # derivation with all the Rust components; including rust-analyzer (LSP)
  ];
}
