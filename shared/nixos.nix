{ pkgs, lib, user, system, ... }:

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
      trusted-public-keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCvxHIphVJVuOhbLtBWoo/fSae1R89RSIdxNp4yi7P0qv49ssHPsS5uicn4+b3BSSsxIOXy4KSmtx/Ti6xVvK3JHeINaDiZn4oiXguqGC25iJePnwDrEJYkmatup4V6phzSOBfD2PWz8gFgPh2UQ7ikRTUiBRIlPxwSt0UY+rmJsqVDT9LJqZ+g67tlxu3tpgoPV7yl0VfL0as8k15Td6Lq01si+g8K9ZG00nYtAoLbirZcvmbutZQc8xiihlwMVaqAzsYYtvCYAcjmJR2AiO7WvH3BYtclo2L8YPLhBDfjUBaZ2sDXUwBd2Uyvkozh+cC/CrqaAKLyLYDFITyF+jr1/Ch8Fdj67gILzI/9uhcDYDcyJ3/qmY2NZu0wSescYgkhi3lik0bK9lcBBzuFn5pP5eQy1CmesVFyRTzdRLHgEwHxjLegT1RVVuAZGv5soXyiSwhzqnjLTx0x7S8yS9+sXBfo2ortEmxrdx/bJs8dtPHzQuf53NRoZge7kVctHTpdjrYrRJK7lGRoK9Eao9C/mTSwh6wXQc+O8chVEgje73jbidOKZm1R8esD8OsW8t/1w7pp8Vv5TeCbf7EUEKdUOLP3ECHkfm5ElqtByUjZvT5D5JD+ZF+LH6pLik2kg41KAYz4wZlm4FlI/NW9JpOL6T8GjqWcadrWmH7NQqE+UQ== kev@nixos.local"
      ];
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
      enable = true;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault system;
}
