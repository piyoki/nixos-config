{ pkgs, ... }:

{
  imports = [
    # default home modules
    ../../shared/home.nix

    # host specific modules

    # shared modules
  ];

  home.packages = with pkgs; [
    bat
    delta
    jq
    lazygit
  ];
}
