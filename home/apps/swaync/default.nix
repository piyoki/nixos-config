{ inputs, system, ... }:

{
  xdg.configFile."swaync".source = inputs.dotfiles.packages.${system}.swaync + "/";
}
