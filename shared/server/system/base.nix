{ sharedLib, ... }:

{
  imports = map sharedLib.relativeToRoot [
    # system modules
    "shared/nixos.nix"
    "system/users/server.nix"
    "system/packages/server.nix"
    "system/services/openssh/server.nix"
    "system/services/zramd.nix"
    "system/internationalisation/locale.nix"
    "system/internationalisation/time.nix"
  ] ++ [
    ./environment
    ./services/qemu-agent.nix
    ./patches/users-shell-bash.nix
  ];
}
