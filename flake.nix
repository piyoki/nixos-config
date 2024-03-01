{
  # NixOS configuration (with HomeManager)
  # build system
  outputs = { nixpkgs, pre-commit-hooks, home-manager, hyprland, sops-nix, daeuniverse, ... }@inputs:
    let
      system = "x86_64-linux";
      # use a system-specific version of nixpkgs
      # pkgs = (import nixpkgs) { inherit system; };
      inherit (nixpkgs) lib;
      inherit (import ./vars.nix) user;
      specialArgs = { inherit inputs system user; };
      homeManagerModuleAttrs =
        {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = specialArgs;
          users.${user} = import ./home;
          sharedModules = [
            sops-nix.homeManagerModules.sops
          ];
        };
      extraModules = [
        hyprland.nixosModules.default
        sops-nix.nixosModules.sops
        daeuniverse.nixosModules.dae
      ];
    in
    {
      checks = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true; # formatter
            statix.enable = true; # linter
          };
        };
      };

      nixosConfigurations = {
        laptop = lib.nixosSystem {
          inherit specialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            { home-manager = homeManagerModuleAttrs; }
          ] ++ extraModules ++ [ ./profiles/thinkpad-x1-carbon/configuration.nix ];
        };

        desktop = { };
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
    daeuniverse.url = "github:daeuniverse/flake.nix/exp";

    # personal nur
    nur.url = "github:yqlbu/nur-packages";

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
