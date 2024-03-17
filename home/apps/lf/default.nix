{ inputs, system, ... }:

{
  xdg.configFile."lf".source = inputs.dotfiles.packages.${system}.lf-universal + "/";
}
