{ pkgs, user, ... }:

# References:
# https://wiki.archlinux.org/title/systemd/User
# https://wiki.archlinux.org/title/Systemd/Timers
# https://man.archlinux.org/man/systemd.timer.5
# https://haseebmajid.dev/posts/2023-10-08-how-to-create-systemd-services-in-nix-home-manager/
# https://gist.github.com/oprypin/0f0c3479ab53e00988b52919e5d7c144/

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
    timerConfig = {
      OnBootSec = "1h";
      OnUnitActiveSec = "1h";
      Unit = "restart-scdaemon.service";
    };
  };

  # systemd service
  systemd.user.services."restart-scdaemon" = {
    Unit = {
      Description = "Restart gnupg scdaemon";
    };
    Install = {
      WantedBy = [ "default.target" ];
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

  # Usage
  # list active timers and their current state:
  # $ systemctl --user list-timers
  # manually run a service once for testing purposes:
  # $ systemctl start --user <service>
}
