{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    inputs.nur.packages.${system}.helloworld
  ];
}
