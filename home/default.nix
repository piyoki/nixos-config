{ sharedLib, ... }:

{
  imports = (sharedLib.scanPaths ./.) ++
    (map sharedLib.relativeToRoot [
      # shared modules
      "shared/home.nix"
    ]);
}
