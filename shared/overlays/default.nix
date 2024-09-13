{ inputs, ... }:

{
  overlays = [
    inputs.chaotic.overlays.default
    inputs.rust-overlay.overlays.default
  ] ++ [
    (import ./webcord.nix { })
  ];
}
