{ pkgs, user, ... }:

# /etc/systemd/system/rclone.service
let
  swBin = "/run/current-system/sw/bin";
  wrapperBin = "/run/wrappers/bin";
  homeDir = "/home/${user}";
in
{
  # mount pikpak webdav drive
  systemd.user.services."rclone" = {
    description = "Mount pikpak webdav drive (Rclone)";
    after = [ "network-pre.target" "NetworkManager.service" "systemd-resolved.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      User = "kev";
      ExecStartPre = "${swBin}/mkdir -p $CACHE_DIR";
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
      Type = "simple";
      ExecStop = "${wrapperBin}/umount $PIKPAK_DIR";
      Environment = [
        "PIKPAK_DIR=${homeDir}/Pikpak"
        "CACHE_DIR=${homeDir}/.cache/rclone"
        "PATH=$PATH:${wrapperBin}:${swBin}"
      ];
    };
  };
}
