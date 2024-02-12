{ inputs, ... }:

{
  xdg.configFile."dunst".source = inputs.dunst + "/";
}
