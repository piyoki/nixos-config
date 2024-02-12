{ inputs, ... }:

{
  xdg.configFile."swappy/config".source = inputs.swappy + "/config";
}
