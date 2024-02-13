{ config, pkgs, ... }:

# $HOME/.config/systemd/user/<name>.service
{
  # power resume hooks
  # relaunch waybars
  systemd.user.services."relaunch-waybars" = {
    Unit = {
      Description = "relaunch waybars when power resumes";
      After = [ "post-resume.target" ];
    };
    Install = {
      WantedBy = [ "post-resume.target" ];
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "relaunch-waybars" ''
        set -eux
        /run/current-system/sw/bin/killall .waybar-wrapped
        /run/current-system/sw/bin/sleep 2
      ''}";
      Type = "oneshot";
      Environment = "CONFIG_DIR=${config.home.homeDirectory}/.config/waybar";
    };
  };
}
