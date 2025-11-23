{ pkgs-stable, ... }:

{
  home.packages = with pkgs-stable; [
    # media
    cava # for visualizing audio

    # development
    nodePackages_latest.vscode-json-languageserver # JSON language server
    ansible-language-server # Ansible language server
  ];
}
