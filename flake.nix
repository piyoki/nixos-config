{
  # NixOS configuration (with HomeManager)
  # build system
  outputs = { nixpkgs, home-manager, ... }@inputs: with inputs;
    let
      system = "x86_64-linux";
      # use a system-specific version of nixpkgs
      pkgs = (import nixpkgs) { inherit system; config.allowUnfree = lib.mkDefault true; };
      inherit (nixpkgs) lib;
      inherit (import ./shared/vars) user;
      inherit (import ./profiles.nix) profiles;
      extraModules = [
        sops-nix.nixosModules.sops
      ];
      # function to generate specialArgs
      genSpecialArgs = system: {
        pkgs-unstable = (import nixpkgs-unstable) { inherit system; config.allowUnfree = lib.mkDefault true; };
        inherit (import ./shared/lib { inherit lib; }) sharedLib;
        inherit inputs pkgs system user;
      };
      # function to generate homeModule
      genHomeModules = homeModules: [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = genSpecialArgs system;
            users.${user} = homeModules;
            sharedModules = [
              sops-nix.homeManagerModules.sops
            ];
          };
        }
      ];
      # function to generate nixosSystem
      genSystem =
        { profile
        , isServer ? false
        , profilePrefix ? (if (!isServer) then ./profiles/workstation/${profile} else ./profiles/server/${profile})
        , hostModules ? (
            [ (profilePrefix + "/configuration.nix") ] ++ (lib.optionals (!isServer) [
              hyprland.nixosModules.default
            ])
          )
        , homeModules ? (genHomeModules (import (profilePrefix + "/home.nix")))
        }: lib.nixosSystem {
          specialArgs = genSpecialArgs system;
          modules = hostModules ++ homeModules ++ extraModules;
        };
      # function to generate remote deploy nixosSystem
      genDeploy =
        { profile
        , hostModules ? [ ./profiles/server/${profile}/configuration.nix ]
        , homeModules ? (genHomeModules (import ./profiles/server/${profile}/home.nix))
        }: {
          deployment = {
            targetHost = "nixos-${profile}";
            inherit (import ./shared/vars) targetPort targetUser tags;
            inherit (import ./shared/server/age-key.nix) keys;
          };
          imports = hostModules ++ homeModules ++ extraModules;
        };
      # function to generate nixosConfigurations with flake
      genFlake = { workstations, servers }: (
        # (lib.attrsets.mergeAttrsList): merge attribute sets, expect input as a list
        lib.attrsets.mergeAttrsList (
          # (map): instantiate nixosConfigurations.${profile} from inputs
          (map (profile: { ${profile} = genSystem { inherit profile; }; }) workstations) ++
          (map (profile: { ${profile} = genSystem { inherit profile; isServer = true; }; }) servers)
        ));
      # function to generate colemna configs with flake for remote deploy
      genColmena = servers: (
        { meta = { nixpkgs = pkgs; specialArgs = genSpecialArgs system; }; } //
        # (lib.attrsets.mergeAttrsList): merge attribute sets, expect input as a list
        lib.attrsets.mergeAttrsList (map (profile: { ${profile} = genDeploy { inherit profile; }; }) servers)
      );
      # function to generate pre-commit-checks
      genChecks = system: (pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          nixpkgs-fmt.enable = true; # formatter
          statix.enable = true; # linter
          deadnix.enable = true; # linter
        };
      });
    in
    {
      # checks
      checks.${system}.pre-commit-check = genChecks system;
      # hosts
      nixosConfigurations = genFlake { inherit (profiles) workstations servers; };
      # remote deploy
      colmena = genColmena profiles.servers;
    };

  inputs = {
    # public source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    haumea = { url = "github:nix-community/haumea/main"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixpkgs-wayland = { url = "github:nix-community/nixpkgs-wayland"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland = { url = "github:hyprwm/Hyprland"; inputs.nixpkgs.follows = "nixpkgs"; };
    impermanence.url = "github:nix-community/impermanence";
    sops-nix.url = "github:Mic92/sops-nix";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # personal nur
    nur.url = "github:yqlbu/nur-packages";
    assets.url = "github:yqlbu/nur-assets";

    # private repos
    secrets = { url = "git+file:/home/kev/flake/secrets?shallow=1"; flake = false; };
    home-estate = { url = "git+file:/home/kev/flake/home-estate?ref=master&shallow=1"; };

    # personal dotfiles
    dotfiles-laptop.url = "git+https://github.com/yqlbu/dotfiles.nix?ref=x1-carbon";
    dotfiles-desktop.url = "git+https://github.com/yqlbu/dotfiles.nix?ref=master";
  };
}
