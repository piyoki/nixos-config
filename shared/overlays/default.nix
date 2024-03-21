{ inputs, ... }:

{
  overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.chaotic.overlays.default
  ] ++
  (import ./webcord.nix { });
}
