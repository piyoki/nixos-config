{ inputs, lib, system, ... }:

# dotfiles overrides based on host profile
{
  xdg.configFile."hypr".source = lib.mkForce (inputs.dotfiles-desktop.packages.${system}.hypr + "/");
  xdg.configFile."waybar".source = lib.mkForce (inputs.dotfiles-desktop.packages.${system}.waybar + "/");
}
