{ pkgs, ... }:

{
  home.packages = with pkgs; [
    python3
    black # The uncompromising Python code formatter
  ];
}
