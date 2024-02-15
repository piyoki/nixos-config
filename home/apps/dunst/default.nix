{ inputs, system, ... }:

{
  xdg.configFile."dunst".source = inputs.dotfiles.packages.${system}.dunst + "/";
}
