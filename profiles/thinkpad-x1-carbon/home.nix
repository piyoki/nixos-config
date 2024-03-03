_:

{
  imports = [
    # default home modules
    ../../home

    # host specific modules
    ./modules/secrets.nix
    ./modules/gnupg.nix
    ./modules/dotfiles.nix
    # ../../shared/modules/home/gnupg.nix
    # { source = ./conf/gpg.conf; }

    # shared modules
  ];
}
