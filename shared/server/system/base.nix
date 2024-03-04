_:

{
  imports = [
    # system modules
    ../../../system/users/server.nix
    ../../../system/users/server.nix
    ../../../system/packages/server.nix
    ../../../system/environment/server.nix
    ../../../system/networking/server.nix
    ../../../system/services/fish.nix
    ../../../system/services/docker.nix
    ../../../system/services/openssh.nix
    ../../../system/services/zramd.nix
    ../../../system/services/gnupg/server.nix
    ../../../system/internationalisation/locale.nix
    ../../../system/internationalisation/time.nix
  ];
}