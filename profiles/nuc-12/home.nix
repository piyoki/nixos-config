_:

{
  imports = [
    # default home modules
    ../../home

    # host specific modules
    ./modules/secrets.nix
    ./modules/gnupg.nix

    # shared modules
  ];
}
