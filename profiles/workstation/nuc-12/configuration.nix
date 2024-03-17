{ inputs, sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # system modules
    "system"
    "system/users/init-pass.nix"

    # themes modules
    "themes"

    # shared modules
    "shared/modules/secrets"
    "shared/modules/system/tmpfs/persistent"
  ]) ++
  [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Set hostname
  networking.hostName = "nixos-nuc-12";

  # Set overlays
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay.default
    inputs.chaotic.overlays.default
  ];

  modules = {
    # Import system secrets
    secrets.workstation.system.enable = true;
    # Load persistent dirs and files
    persistent = {
      enable = true;
      hostType = "workstation";
    };
  };
}
