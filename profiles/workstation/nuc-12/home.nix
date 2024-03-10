_:

{
  imports = [
    # default home modules
    ../../../home

    # host specific modules
    ./secrets

    # shared modules
    ../../../shared/modules/secrets
    (import ../../../shared/modules/home/gnupg.nix ./conf/gpg.conf)
  ];

  # Import secrets
  config.modules.secrets.workstation.home.enable = true;
}
