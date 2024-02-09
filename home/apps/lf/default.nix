{ inputs, ... }:

{
  xdg.configFile."lf".source = (inputs.lf + "/");
}

