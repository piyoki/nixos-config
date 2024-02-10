{ ... }:

{
  xdg.configFile."colorscheme/colorscheme".text = builtins.readFile ../../../colorscheme;
}
