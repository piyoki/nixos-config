{ pkgs, ... }:

{
  imports = [
    # host specific modules
    ../../home/apps/fish
    ../../home/services/encryption/server.nix

    # shared modules
    ../../shared/options.nix
    ../../shared/home.nix
  ];

  home.packages = with pkgs; [
    bat
    delta
    jq
    lazygit
    vivid
  ];
}
