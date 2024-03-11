{ sharedLib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # default home modules
    "home"

    # shared modules
    "shared/modules/secrets"
  ]) ++ [
    # host specific modules
    ./secrets

    # shared modules
    (import ../../../shared/modules/home/gnupg.nix ./conf/gpg.conf)
  ];

  # Import secrets
  config.modules.secrets.workstation.home.enable = true;
}
