{ pkgs, ... }:

{
  imports = [
    # host specific modules
    ../../home/apps/fish

    # shared modules
    ../../shared/options.nix
    ../../shared/home.nix
  ];

  home.packages = with pkgs; [
    bat
    delta
    jq
    lazygit
  ];
}
