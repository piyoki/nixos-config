{ inputs, user, ... }:

{
  # overlays
  nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];

  # home-manager basic settings
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    inherit (import ./vars) stateVersion;
  };

  programs.home-manager.enable = true;
}
