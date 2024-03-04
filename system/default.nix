_:

{
  imports = [
    # system default modules
    ./hardware
    ./networking
    ./security
    ./services
    ./secrets
    ./users
    ./environment
    ./packages
    ./internationalisation

    # shared modules
    ../shared/nixos.nix
  ];
}
