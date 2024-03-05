{
  # NixOS configuration (with HomeManager)
  # build system
  outputs = { nixpkgs, pre-commit-hooks, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      # use a system-specific version of nixpkgs
      pkgs = (import nixpkgs) {
        inherit system;
        config.allowUnfree = lib.mkDefault true;
      };
      inherit (nixpkgs) lib;
      inherit (import ./shared/vars) user;
      specialArgs = { inherit inputs pkgs system user; };
      extraModules = with inputs; [
        impermanence.nixosModules.impermanence
        hyprland.nixosModules.default
        sops-nix.nixosModules.sops
        daeuniverse.nixosModules.dae
      ];
      # function to generate homeModule
      genHomeModules = homeModules: [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.${user} = homeModules;
            sharedModules = with inputs; [
              sops-nix.homeManagerModules.sops
            ];
          };
        }
      ];
      # function to generate nixosSystem
      genSystem =
        { profile
        , hostModules ? [ ./profiles/${profile}/configuration.nix ]
        , homeModules ? (genHomeModules (import ./profiles/${profile}/home.nix))
        }: lib.nixosSystem {
          inherit specialArgs;
          modules = hostModules ++ homeModules ++ extraModules;
        };
      # function to generate remote deploy nixosSystem
      genDeploy =
        { profile
        , hostModules ? [ ./profiles/${profile}/configuration.nix ]
        , homeModules ? (genHomeModules (import ./profiles/${profile}/home.nix))
        }: {
          deployment = {
            targetHost = "nixos-${profile}";
            inherit (import ./shared/vars) targetPort targetUser tags;
            inherit (import ./shared/server/secrets) keys;
          };
          imports = hostModules ++ homeModules;
        };
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
        # daily-drivers
        laptop = genSystem { profile = "thinkpad-x1-carbon"; };
        desktop = genSystem { profile = "nuc-12"; };
        # servers
        mars = genSystem { profile = "mars"; };
      };

      # remote deploy
      colmena = {
        meta = {
          nixpkgs = pkgs;
          inherit specialArgs;
        };

        # servers
        mars = genDeploy { profile = "mars"; };
      };
    };

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
    impermanence.url = "github:nix-community/impermanence";
    sops-nix.url = "github:Mic92/sops-nix";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    daeuniverse.url = "github:daeuniverse/flake.nix/exp";

    # personal nur
    nur.url = "github:yqlbu/nur-packages";

    # private repos
    secrets = {
      # url = "git+file:/home/kev/flake/secrets?shallow=1";
      url = "path:/home/kev/flake/secrets";
      flake = false;
    };
    home-estate = {
      # url = "git+file:/home/kev/flake/home-estate?shallow=1";
      url = "path:/home/kev/flake/home-estate";
      flake = false;
    };

    # personal dotfiles
    dotfiles-laptop.url = "git+https://github.com/yqlbu/dotfiles.nix?ref=x1-carbon";
    dotfiles-desktop.url = "git+https://github.com/yqlbu/dotfiles.nix?ref=master";
  };
}
