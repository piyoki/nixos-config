{ inputs, ... }:

{
  xdg.configFile."rofi".source = (inputs.rofi + "/");
}
