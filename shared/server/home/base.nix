_:

{
  imports = [
    # common modules
    ./packages.nix
    ../../home.nix
    ../../options.nix

    # home modules
    ../../../home/apps/fish
    ../../../home/apps/tmux
    ../../../home/apps/bat
  ];
}
