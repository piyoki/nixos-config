{ inputs, system, ... }:

{
  xdg.configFile."lazygit/config.yml".source = inputs.dotfiles.packages.${system}.lazygit + "/config.yml";
}
