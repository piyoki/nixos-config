{ inputs, system, ... }:

{
  xdg.configFile."waybar".source = inputs.dotfiles.packages.${system}.waybar + "/";
}
