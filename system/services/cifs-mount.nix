{ user, config, ... }:

let
  host = "10.178.0.81";
  homeDir = "/home/${user}";
  mountOpts = [
    # https://www.freedesktop.org/software/systemd/man/latest/systemd.mount.html
    "nofail,_netdev"
    "uid=1000,gid=100,dir_mode=0755,file_mode=0755,iocharset=utf8,auto"
    "vers=3.0,credentials=${config.sops.secrets."samba/qnap".path}"
  ];
  fsType = "cifs";
in
{
  # mount smb/cifs share
  fileSystems."${homeDir}/Tank" = {
    device = "//${host}/Tank";
    inherit fsType;
    options = mountOpts;
  };
  fileSystems."${homeDir}/Media" = {
    device = "//${host}/Media";
    inherit fsType;
    options = mountOpts;
  };
}
