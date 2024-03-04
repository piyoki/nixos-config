{ pkgs, ... }:

{
  imports = [ ./agent.nix ];

  environment.systemPackages = with pkgs; [
    gnupg
    pinentry # GnuPG’s interface to passphrase input
  ];
}
