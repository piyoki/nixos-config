{ pkgs, lib, user, ... }:

{
  # Ref: https://nixos.wiki/wiki/Nixos-rebuild
  nix = {
    # enable flake
    package = pkgs.nixVersions.stable;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      # enable auto-cleanup
      auto-optimise-store = true;
      # set max-jobs
      max-jobs = lib.mkDefault 8;
      # enable ccache (local compilation)
      # extra-sandbox-paths = [ config.programs.ccache.cacheDir ];
      trusted-users = [ user ];
      # trusted-public-keys = [ ];

      # substituers will be appended to the default substituters when fetching packages
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org/"
        "https://nyx.chaotic.cx/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];
      extra-substituters = [
        # "https://s3.homelab.local/nix-cache/"
        "https://cache.garnix.io/"
        "https://nixospilots.cachix.org/"
        "https://nixpkgs-wayland.cachix.org/"
        "https://hyprland.cachix.org/"
      ];
      extra-trusted-public-keys = [
        # "s3.homelab.local-1:RdTo2PHh1D/vIAHLK2VwNGav/9aKUuUmlpLLXHKHuDQ="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nixospilots.cachix.org-1:agmYn3jPCVyiqhSfyPtW8vjB4WavuEdSv49skpup2XE="
      ];
      # ref: https://github.com/NixOS/nix/issues/4894
      # workaround to fix ssh signature issues
      require-sigs = false;
      secret-key-files = "/home/${user}/.config/nix/secret.key";
    };

    # garbage collection
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete older-than 3d";
    };
  };

  system = {
    inherit (import ../shared/vars) stateVersion;
    autoUpgrade = {
      # Whether to periodically upgrade NixOS to the latest version.
      # If enabled, a systemd timer will run nixos-rebuild switch --upgrade once a day.
      enable = false;
    };
  };

  systemd.services.nix-daemon = {
    environment = {
      NIX_GIT_SSL_CAINFO = "/etc/ssl/certs/ca-certificates.crt";
      NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    };
  };
}
