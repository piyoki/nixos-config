{ inputs, system, ... }:

{
  xdg.configFile."kitty/kitty.conf".source = inputs.dotfiles.packages.${system}.kitty + "/kitty.conf";
}
