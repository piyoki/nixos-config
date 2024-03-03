_:

{
  imports = [
    # default home modules
    ../../home

    # custom home modules
    ./modules/secrets.nix
    ./modules/dotfiles.nix
    ./modules/gnupg.nix
  ];
}
