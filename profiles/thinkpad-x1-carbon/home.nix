_:

{
  imports = [
    # default home modules
    ../../home

    # host specific modules
    ./secrets
    ./modules/dotfiles.nix

    # shared modules
    ../../shared/modules/secrets
    (import ../../shared/modules/home/gnupg.nix ./conf/gpg.conf)
  ];

  config.modules.secrets.daily-driver.enable = true;
}
