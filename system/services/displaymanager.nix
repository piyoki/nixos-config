{ user, ... }:

{
  # enable hyprland
  programs.hyprland.enable = true;

  # enable sddm
  services.xserver = {
    enable = true;
    displayManager = {
      defaultSession = "hyprland";
      sddm = {
        enable = true;
        enableHidpi = true;
        wayland.enable = true;
        settings = {
          Autologin = {
            Session = "hyprland";
            User = user;
          };
        };
      };
    };
  };
}
