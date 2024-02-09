{ inputs, ... }:

{
  xdg.configFile."lazygit/config.yml".source = (inputs.lazygit + "/config.yml");
}
