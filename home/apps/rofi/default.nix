{ inputs, system, ... }:

{
  xdg.configFile."rofi".source = inputs.dotfiles.packages.${system}.rofi + "/";
}
