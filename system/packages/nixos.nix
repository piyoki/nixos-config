{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # nix usage
    nixpkgs-fmt # Nix code formatter for nixpkgs
    nix-prefetch-scripts # Collection of all the nix-prefetch-* scripts which may be used to obtain source hashes
    update-nix-fetchgit # A program to update fetchgit values in Nix expressions
    statix # Lints and suggestions for the Nix programming language
    deadnix # Find and remove unused code in .nix source files
    nix-output-monitor # Processes output of Nix commands to show helpful and pretty information
  ];
}
