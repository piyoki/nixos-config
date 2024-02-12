{ inputs, ... }:

{
  xdg.configFile."kitty/kitty.conf".source = inputs.kitty + "/kitty.conf";
}
