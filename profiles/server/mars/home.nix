{ lib, ... }:

{
  imports = [
    # host specific modules
    ../../../home/apps/lazygit
    (import ../../../home/services/encryption/server.nix { restart = false; inherit lib; })
    (import ../../../shared/modules/home/gnupg.nix ../../../shared/server/conf/gnupg.conf)

    # shared modules
    ../../../shared/server/home/base.nix
  ];
}
