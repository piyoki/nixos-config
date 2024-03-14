{ sharedLib, ... }:

{
  imports = map sharedLib.relativeToRoot [
    # common modules
    "shared/home.nix"

    # home modules
    "home/apps/tmux"
    "home/apps/bat"
  ];
}
