{ pkgs, user, ... }:

# $HOME/.config/systemd/user/<name>.{time,service}
{
  # systemd timer
  systemd.user.timers."restart-scdaemon" = {
    Unit = {
      Description = "Systemd timer for restart-scdaemon.service, run every 1h";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
    Timer = {
      OnBootSec = "1h";
      OnUnitActiveSec = "1h";
    };
  };

  # systemd service
  systemd.user.services."restart-scdaemon" = {
    Unit = {
      Description = "Restart gnupg scdaemon";
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "restart-scdaemon" ''
        set -eu
        /run/current-system/sw/bin/killall gpg-agent
        /run/current-system/sw/bin/gpgconf --reload scdaemon
      ''}";
      Type = "oneshot";
    };
  };
}

