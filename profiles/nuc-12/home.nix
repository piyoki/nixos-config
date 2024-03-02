{ inputs, system, lib, pkgs, ... }:

{
  imports = [
    ./modules/secrets.nix
    ./modules/dotfiles.nix
  ];

  home = {
    file = {
      # gnupg
      ".gnupg/gpg.conf".text = builtins.readFile ./conf/gpg.conf;
    };
  };
}
