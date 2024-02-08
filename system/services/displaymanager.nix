{ ... }:

let
  user = (import ../../vars.nix).user;
in
{
  services.xserver = {
    enable = true;
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
    windowManager = {
      default = "Hyprland";
    };

    # enable hyprland
    programs.hyprland.enable = true;
  };
}
