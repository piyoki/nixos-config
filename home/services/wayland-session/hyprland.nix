{ inputs, system, ... }:

{
  # wayland-session
  # NOTE: this executable is used by greetd to start a wayland session when system boot up
  # with such a vendor-no-locking script, we can switch to another wayland compositor without modifying greetd's config in NixOS module
  home.file.".wayland-session" = {
    source = "${inputs.hyprland.packages.${system}.hyprland}/bin/start-hyprland";
    executable = true;
  };
}
