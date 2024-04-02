{ pkgs, lib, user, ... }:

{
  # Ref: https://nixos.wiki/wiki/Nixos-rebuild
  nix = {
    # enable flake
    package = pkgs.nixFlakes;
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
      extra-substituters = [
        "https://s3.homelab.sh/nix-cache/"
        "https://nyx.chaotic.cx/"
        "https://nixospilots.cachix.org/"
        "https://nix-community.cachix.org/"
        "https://nixpkgs-wayland.cachix.org/"
        "https://hyprland.cachix.org/"
      ];
      extra-trusted-public-keys = [
        "s3.homelab.sh:38Vu33SlYUZIrMoWkixfiPmkYfrLWGWI0VTVR1YvPok="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixospilots.cachix.org-1:agmYn3jPCVyiqhSfyPtW8vjB4WavuEdSv49skpup2XE="
      ];
      # ref: https://github.com/NixOS/nix/issues/4894
      # workaround to fix ssh signature issues
      require-sigs = false;
      secret-key-files = "/home/${user}/secret.key";
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
      NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
    };
  };
}
