{ config, pkgs, user, ... }:

# $HOME/.config/systemd/user/rclone.service
{
  # mount pikpak webdav drive
  systemd.user.services."rclone" = {
    Unit = {
      Description = "Mount pikpak webdav drive (Rclone)";
    };
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "rclone" ''
        set -eux
        ${pkgs.waybar}/bin/rclone mount pikpak:/ $PIKPAK_DIR \
          --use-mmap \
          --umask 000 \
          --allow-non-empty \
          --no-check-certificate \
          --attr-timeout 5m \
          --cache-dir $CACHE_DIR \
          --vfs-cache-mode writes \
          --copy-links --no-gzip-encoding \
          --pikpak-use-trash=false \
          --log-level INFO
      ''}";
      Type = "oneshot";
      Environment = [
        "PIKPAK_DIR=${config.home.homeDirectory}/Pikpak"
        "CACHE_DIR=${config.home.homeDirectory}/.cache/rclone"
      ];
      Restart = "on-abort";
    };
  };
}
