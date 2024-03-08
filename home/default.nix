_:

{
  imports = [
    ./assets
    ./packages
    ./services
    ./themes
    ./maintenance
    ./apps.nix

    # shared modules
    ../shared/options.nix
    ../shared/home.nix
  ];
}
