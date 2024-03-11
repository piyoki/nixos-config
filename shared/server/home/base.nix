{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # common modules
    "shared/home.nix"
    "shared/options.nix"

    # home modules
    "home/apps/fish"
    "home/apps/tmux"
    "home/apps/bat"
  ]) ++ [
    # common modules
    ./packages.nix
  ];
}
