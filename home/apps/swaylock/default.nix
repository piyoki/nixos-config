{ inputs, system, ... }:

{
  xdg.configFile."swaylock/config".source = inputs.dotfiles.packages.${system}.swaylock-universal + "/config";
}
