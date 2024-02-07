{
  # define channels
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    flake-utils.url = "github:numtide/flake-utils";
    daeuniverse.url = "github:daeuniverse/flake.nix/sync-upstream";
  };

  outputs = { self, nixpkgs, home-manager, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      lib = nixpkgs.lib;
      user = (import ./vars.nix).user;
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit inputs system; };
          modules = [
            ./profiles/thinkpad-x1-carbon/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs system user; };
              home-manager.users.${user} = import ./home;
            }
            sops-nix.nixosModules.sops
          ];
        };
      };
    };
}
