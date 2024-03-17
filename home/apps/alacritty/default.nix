{ inputs, system, ... }:

{
  xdg.configFile."alacritty/alacritty.toml".source = inputs.dotfiles.packages.${system}.alacritty-universal + "/alacritty.toml";
}
