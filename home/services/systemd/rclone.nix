{ config, pkgs, ... }:

# $HOME/.config/systemd/user/rclone.service
{
  # mount pikpak webdav drive
  systemd.user.services."rclone" = {
    Unit = {
      Description = "Mount pikpak webdav drive (Rclone)";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStartPre = "/run/current-system/sw/bin/mkdir -p $CACHE_DIR";
      ExecStart = "${pkgs.writeShellScript "rclone" ''
        set -eux
        ${pkgs.rclone}/bin/rclone mount pikpak:/ $PIKPAK_DIR \
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
      ExecStop = "/run/wrappers/bin/umount $PIKPAK_DIR";
      Environment = [
        "PIKPAK_DIR=${config.home.homeDirectory}/Pikpak"
        "CACHE_DIR=${config.home.homeDirectory}/.cache/rclone"
        "PATH=$PATH:/run/wrappers/bin"
      ];
    };
  };
}
