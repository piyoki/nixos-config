{ inputs, ... }:

{
  xdg.configFile."nvim".source = (inputs.nvim + "/");
}
