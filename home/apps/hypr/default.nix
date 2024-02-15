{ inputs, system, ... }:

{
  xdg.configFile."hypr".source = inputs.dotfiles.packages.${system}.hypr + "/";
}
