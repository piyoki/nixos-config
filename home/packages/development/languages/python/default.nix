{ pkgs, ... }:

{
  home.packages = with pkgs; [
    python3

    # (python3.withPackages (python-pkgs: with python-pkgs; [
    #   black # The uncompromising Python code formatter
    #   setuptools # Utilities to facilitate the installation of Python packages
    # ]))
  ];
}
