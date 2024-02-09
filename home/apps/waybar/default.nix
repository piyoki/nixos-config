{ inputs, ... }:

{
  xdg.configFile."waybar".source = (inputs.waybar + "/");
}
