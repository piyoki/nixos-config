{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnupg # Modern release of the GNU Privacy Guard, a GPL OpenPGP implementation
    pinentry # GnuPG’s interface to passphrase input
  ];
}
