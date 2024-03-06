_:

{
  imports = [
    ./packages
    ./services
    ./themes
    ./secrets
    ./maintenance
    ./apps.nix

    # shared modules
    ../shared/options.nix
    ../shared/home.nix
  ];
}
