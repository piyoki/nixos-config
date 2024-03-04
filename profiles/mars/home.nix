_:

{
  imports = [
    # host specific modules
    ../../home/apps/fish
    ../../home/apps/tmux
    ../../home/apps/lazygit
    ../../home/apps/bat
    ../../home/services/encryption/server.nix
    ../../home/packages/server

    # shared modules
    ../../shared/options.nix
    ../../shared/home.nix
  ];
}
