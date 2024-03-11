{ sharedLib, lib, ... }:

{
  imports = (map sharedLib.relativeToRoot [
    # host specific modules
    "home/apps/lazygit"

    # shared modules
    "shared/server/home/base.nix"
  ]) ++ [
    # host specific modules
    (import ../../../home/services/encryption/server.nix { restart = false; inherit lib; })
    (import ../../../shared/modules/home/gnupg ../../../shared/server/conf/gnupg.conf)
  ];
}
