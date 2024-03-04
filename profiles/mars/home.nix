_:

{
  imports = [
    # default home modules
    ../../home/server.nix

    # host specific modules

    # shared modules
    ../../shared/options.nix
    ../../shared/home.nix
  ];
}
