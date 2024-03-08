_:

{
  imports = [
    # host specific modules
    ../../../home/apps/lazygit
    ../../../home/services/encryption/server.nix
    (import ../../../shared/modules/home/gnupg.nix ../../../shared/server/conf/gnupg.conf)

    # shared modules
    ../../../shared/server/home/base.nix
  ];
}
