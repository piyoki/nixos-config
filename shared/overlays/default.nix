{ inputs, ... }:

{
  overlays = [
    inputs.chaotic.overlays.default
  ] ++ [
    (import ./webcord.nix { })
    (import ./discord.nix { })
  ];
}
