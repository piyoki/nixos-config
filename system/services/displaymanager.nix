{ user, ... }:

{
  # sddm settings
  services.xserver = {
    enable = false; # disable xorg server
    displayManager = {
      defaultSession = "hyprland";
      sddm = {
        enable = false;
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
