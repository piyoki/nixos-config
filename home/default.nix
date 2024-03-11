{ sharedLib, ... }:

{
  imports = (sharedLib.scanPaths ./.) ++
    (map sharedLib.relativeToRoot [
      # shared modules
      "shared/options.nix"
      "shared/home.nix"
    ]);
}
