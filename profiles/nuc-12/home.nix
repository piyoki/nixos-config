_:

{
  imports = [
    # default home modules
    ../../home

    # host specific modules
    ./secrets

    # shared modules
    (import ../../shared/modules/home/gnupg.nix ./conf/gpg.conf)
  ];
}
