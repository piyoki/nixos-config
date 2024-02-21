{
  # build system
  outputs = { self, nixpkgs, home-manager, hyprland, sops-nix, daeuniverse, ... }@inputs:
    let
      system = "x86_64-linux";
      # use a system-specific version of nixpkgs
      # pkgs = (import nixpkgs) { inherit system; };
      inherit (nixpkgs) lib;
      inherit (import ./vars.nix) user;
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit inputs system user; };
          modules = [
            ./profiles/thinkpad-x1-carbon/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs system user; };
                users.${user} = import ./home;
                sharedModules = [
                  sops-nix.homeManagerModules.sops
                ];
              };
            }
            hyprland.nixosModules.default
            sops-nix.nixosModules.sops
            daeuniverse.nixosModules.dae
          ];
        };
      };
    };

  # define channels
  inputs = {
    # public source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    sops-nix.url = "github:Mic92/sops-nix";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    flake-utils.url = "github:numtide/flake-utils";
    daeuniverse.url = "github:daeuniverse/flake.nix/exp";
    helloworld.url = "github:yqlbu/helloworld.nix";

    # private repos
    secrets = {
      url = "path:/home/kev/flake/secrets";
      flake = false;
    };
    home-estate = {
      url = "path:/home/kev/flake/home-estate";
      flake = false;
    };

    # personal dotfiles
    dotfiles.url = "git+https://github.com/yqlbu/dotfiles.nix?ref=master";
  };
}
