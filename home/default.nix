{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # shared modules
    "shared/options.nix"
    "shared/home.nix"
  ]) ++ [
    ./assets
    ./packages
    ./services
    ./themes
    ./maintenance
    ./apps.nix
  ];
}
