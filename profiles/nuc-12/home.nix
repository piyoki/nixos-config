_:

{
  imports = [
    # default home modules
    ../../home

    # host specific modules
    ./secrets

    # shared modules
    ../../shared/modules/secrets
    (import ../../shared/modules/home/gnupg.nix ./conf/gpg.conf)
  ];

  config.modules.secrets.home.daily-driver.enable = true;
}
