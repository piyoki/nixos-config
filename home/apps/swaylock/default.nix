{ inputs, ... }:

{
  xdg.configFile."swaylock/config".source = (inputs.swaylock + "/config");
}
