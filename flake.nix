{
  # NixOS configuration (with HomeManager)
  # build system
  outputs = { nixpkgs, pre-commit-hooks, home-manager, ... }@inputs: with inputs;
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
      extraModules = [
        sops-nix.nixosModules.sops
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
        , profilePrefix ? (if (!isServer) then ./profiles/daily-drivers/${profile} else ./profiles/server/${profile})
        , hostModules ? (
            [ (profilePrefix + "/configuration.nix") ] ++
            (if (!isServer) then [ hyprland.nixosModules.default ] else [ ])
          )
        , homeModules ? (genHomeModules (import (profilePrefix + "/home.nix")))
        }: lib.nixosSystem {
          inherit specialArgs;
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
      genFlake = { daily-drivers, servers }: (
        # (lib.attrsets.mergeAttrsList): merge attribute sets, expect input as a list
        lib.attrsets.mergeAttrsList (
          # (map): instantiate nixosConfigurations.${profile} from inputs
          (map (profile: { ${profile} = genSystem { inherit profile; }; }) daily-drivers) ++
          (map (profile: { ${profile} = genSystem { inherit profile; isServer = true; }; }) servers)
        ));
      # function to generate colemna configs with flake for remote deploy
      genColmena = servers: (
        { meta = { nixpkgs = pkgs; inherit specialArgs; }; } //
        # (lib.attrsets.mergeAttrsList): merge attribute sets, expect input as a list
        lib.attrsets.mergeAttrsList (map (profile: { ${profile} = genDeploy { inherit profile; }; }) servers)
      );
      # host profiles
      profiles = {
        daily-drivers = [
          "thinkpad-x1-carbon"
          "nuc-12"
        ];
        servers = [
          "mars"
          "felix"
        ];
      };
    in
    {
      # checks
      checks = {
        pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true; # formatter
            statix.enable = true; # linter
          };
        };
      };

      # hosts
      nixosConfigurations = genFlake {
        inherit (profiles) daily-drivers servers;
      };

      # remote deploy
      colmena = genColmena profiles.servers;

      # development
      devShell = nixpkgs.legacyPackages.${system}.mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    };

  inputs =
    {
      # public source
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      haumea = {
        url = "github:nix-community/haumea/main";
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
      assets.url = "github:yqlbu/nur-assets";

      # private repos
      secrets = {
        url = "git+file:/home/kev/flake/secrets?shallow=1";
        # url = "path:/home/kev/flake/secrets";
        flake = false;
      };
      home-estate = {
        url = "git+file:/home/kev/flake/home-estate?shallow=1";
        # url = "path:/home/kev/flake/home-estate";
        flake = false;
      };

      # personal dotfiles
      dotfiles-laptop.url = "git+https://github.com/yqlbu/dotfiles.nix?ref=x1-carbon";
      dotfiles-desktop.url = "git+https://github.com/yqlbu/dotfiles.nix?ref=master";
    };
}
