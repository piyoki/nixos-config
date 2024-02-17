{ pkgs, user, ... }:

# $HOME/.config/systemd/user/lockscreen.service
{
  # power resume hooks
  systemd.user.services."lockscreen" = {
    Unit = {
      Description = "lockscreen before sleep";
      Before = [ "sleep.target" ];
    };
    Install = {
      WantedBy = [ "sleep.target" ];
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "lockscreen" ''
        set -eux
        /etc/profiles/per-user/${user}/bin/swaylock -f
      ''}";
      ExecStartPost = "/run/current-system/sw/bin/sleep 1";
      Type = "oneshot";
      Environment = [ "DISPLAY=:0" ];
    };
  };
}
