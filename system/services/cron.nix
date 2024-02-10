{ ... }:

# Reference: https://nixos.wiki/wiki/Systemd/Timers
{
  # systemd timer
  systemd.timers."restart-scdaemon" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "10m";
        OnUnitActiveSec = "10m";
        Unit = "restart-scdaemon.service";
      };
  };

  systemd.services."restart-scdaemon" = {
    script = ''
      set -eu
      gpgconf --reload scdaemon
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  # Usage
  # list active timers and their current state:
  # $ systemctl list-timers
  # manually run a service once for testing purposes:
  # $ systemctl start hello-world
}
