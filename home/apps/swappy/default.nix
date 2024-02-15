{ inputs, system, ... }:

{
  xdg.configFile."swappy/config".source = inputs.dotfiles.packages.${system}.swappy + "/config";
}
