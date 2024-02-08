{ lib, ... }:

let
  user = (import ../../vars.nix).user;
in
{
  # enable hyprland
  programs.hyprland.enable = true;

  # enable gdm
  services.xserver = {
    displayManager.lightdm.greeters.mini = {
      enable = true;
      user = user;
      extraConfig = ''
        [greeter]
        show-password-label = false
        [greeter-theme]
        background-image = ""
      '';
    };

    # set a default session
    # windowManager = {
    #   default = "hyprland";
    # };
  };
}
