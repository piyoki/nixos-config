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
      specialArgs = genSpecialArgs system;
      profiles = import ./profiles.nix { };
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
            extraSpecialArgs = specialArgs;
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
        , profilePrefix ? (if (!isServer) then ./profiles/workstation/${profile.hostname} else ./profiles/server/${profile.hostname})
        , hostModules ? (
            [ (profilePrefix + "/configuration.nix") ] ++ (lib.optionals (!isServer) [
              hyprland.nixosModules.default
            ])
          )
        , homeModules ? lib.optionals profile.home-manager (genHomeModules (import (profilePrefix + "/home.nix")))
        }: lib.nixosSystem {
          inherit specialArgs;
          modules = hostModules ++ homeModules ++ extraModules;
        };
      # function to generate remote deploy nixosSystem
      genDeploy =
        { profile
        , hostModules ? [ ./profiles/server/${profile.hostname}/configuration.nix ]
        , homeModules ? lib.optionals profile.home-manager (genHomeModules (import ./profiles/server/${profile.hostname}/home.nix))
        }: {
          deployment = {
            targetHost = "nixos-${profile.hostname}";
            inherit (import ./shared/vars) targetPort targetUser tags;
            inherit (profile) keys;
          };
          imports = hostModules ++ homeModules ++ extraModules;
        };
      # function to generate nixosSystem for microvm
      genMicroVM =
        { profile
        , hostModules ? [
            microvm.nixosModules.microvm
            (import ./shared/modules/microvm/${profile.hostname}.nix)
          ]
        }: lib.nixosSystem {
          inherit specialArgs;
          modules = hostModules;
        };
      # function to generate nixosConfigurations with flake
      genFlake = profiles: with profiles; (
        # (lib.attrsets.mergeAttrsList): merge attribute sets, expect input as a list
        lib.attrsets.mergeAttrsList (
          # (map): instantiate nixosConfigurations.${profile} from inputs
          (map (profile: { ${profile.hostname} = genSystem { inherit profile; }; }) workstations) ++
          (map (profile: { ${profile.hostname} = genSystem { inherit profile; isServer = true; }; }) servers) ++
          (map (profile: { "${profile.hostname}-microvm" = genMicroVM { inherit profile; }; }) microvms)
        ));
      # function to generate colemna configs with flake for remote deploy
      genColmena = servers: (
        { meta = { nixpkgs = pkgs; inherit specialArgs; }; } //
        # (lib.attrsets.mergeAttrsList): merge attribute sets, expect input as a list
        lib.attrsets.mergeAttrsList (map (profile: { ${profile.hostname} = genDeploy { inherit profile; }; }) servers)
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
      # function to generate nix packages
      genPkgs = microvms: lib.attrsets.mergeAttrsList (map
        (profile: {
          "${profile.hostname}-microvm" = self.nixosConfigurations."${profile.hostname}-microvm".config.microvm.declaredRunner;
        })
        microvms
      );
    in
    with profiles;
    {
      # checks
      checks.${system}.pre-commit-check = genChecks system;
      # hosts
      nixosConfigurations = genFlake profiles;
      # remote deploy
      colmena = genColmena servers;
      # packages
      packages.${system} = genPkgs microvms;
    };

  inputs = {
    # public source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    sops-nix.url = "github:Mic92/sops-nix";
    nixpkgs-wayland = { url = "github:nix-community/nixpkgs-wayland"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland = { url = "github:hyprwm/Hyprland"; inputs.nixpkgs.follows = "nixpkgs"; };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    impermanence.url = "github:nix-community/impermanence";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    microvm = { url = "github:astro/microvm.nix"; inputs.nixpkgs.follows = "nixpkgs"; };

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
