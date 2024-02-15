{ inputs, system, ... }:

{
  xdg.configFile."nvim".source = inputs.dotfiles.packages.${system}.nvim + "/";
}
