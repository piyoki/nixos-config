{ pkgs, ... }:

{
  home.packages = with pkgs; [
    shfmt # Shell parser and formatter
  ];
}
