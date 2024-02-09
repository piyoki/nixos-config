{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    inputs.helloworld.packages.${system}.helloworld
  ];

  xdg.configFile."helloworld".source = inputs.helloworld;
}
