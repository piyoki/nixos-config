{ pkgs, ... }:

{
  home.packages = with pkgs; [
    sops # Simple and flexible tool for managing secrets
    age # Modern encryption tool with small explicit keys
    age-plugin-yubikey # YubiKey plugin for age
    yubikey-manager # Command line tool for configuring any YubiKey over all USB transports
    yubioath-flutter # Yubico Authenticator for Desktop
  ];

  home.file.".gnupg/scdaemon.conf".text = builtins.readFile ./scdaemon.conf;
}
