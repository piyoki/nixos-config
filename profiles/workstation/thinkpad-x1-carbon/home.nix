{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # default home modules
    "home"

    # shared modules
    "shared/modules/secrets"
  ]) ++ [
    # host specific modules
    ./home-secrets
    ./modules/dotfiles.nix

    # shared modules
    (import ../../../shared/modules/home/gnupg ./conf/gpg.conf)
  ];

  # Import home secrets
  config.modules.secrets.workstation.home.enable = true;
}
