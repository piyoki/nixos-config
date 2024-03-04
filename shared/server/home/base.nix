_:

{
  imports = [
    # common modules
    ./packages.nix

    # home modules
    ../../../home/apps/fish
    ../../../home/apps/tmux
    ../../../home/apps/lazygit
    ../../../home/apps/bat
    # ../../../home/services/encryption/server.nix
  ];
}
