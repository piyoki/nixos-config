{ inputs, system, ... }:

{
  xdg.configFile."foot/foot.ini".source = inputs.dotfiles.packages.${system}.foot-universal + "/foot.ini";
}
