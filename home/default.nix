_:

{
  imports = [
    ./common
    ./packages
    ./services
    ./themes
    ./secrets
    ./maintenance
    ./apps.nix
  ];

  programs.go.enable = true;
}
