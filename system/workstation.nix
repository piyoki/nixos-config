{ sharedLib, ... }:

{
  imports = (sharedLib.scanPaths ./.) ++
    (map sharedLib.relativeToRoot [
      # shared modules
      "shared/nixos.nix"
    ]);
}
