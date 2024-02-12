{ inputs, ... }:

{
  xdg.configFile."hypr".source = inputs.hypr + "/";
}
