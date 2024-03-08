_:

{
  imports = [
    # system modules
    ../../nixos.nix
    ../../../system/users/server.nix
    ../../../system/packages/server.nix
    ../../../system/environment/server.nix
    ../../../system/services/fish.nix
    ../../../system/services/openssh/server.nix
    ../../../system/services/zramd.nix
    ../../../system/internationalisation/locale.nix
    ../../../system/internationalisation/time.nix
  ];
}
