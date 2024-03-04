_:

{
  imports = [
    # system default modules
    ./users/server.nix
    ./packages/server.nix
    ./environment/server.nix
    ./networking/server.nix
    ./services/fish.nix
    ./services/docker.nix
    ./services/openssh.nix
    ./services/zramd.nix
    ./services/gnupg/server.nix
    ./internationalisation/locale.nix
    ./internationalisation/time.nix
  ];
}
