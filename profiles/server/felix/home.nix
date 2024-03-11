{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules

    # shared modules
    "shared/server/home/base.nix"
  ]);
}
