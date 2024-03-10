{ inputs, lib, config, ... }:

# NOTES:
# Permission modes are in octal representation (same as chmod),
# the digits represent: user|group|others
# 7 - full (rwx)
# 6 - read and write (rw-)
# 5 - read and execute (r-x)
# 4 - read only (r--)
# 3 - write and execute (-wx)
# 2 - write only (-w-)
# 1 - execute only (--x)
# 0 - none (---)

# Reference: https://github.com/Mic92/sops-nix

with lib;
let
  cfg = config.modules.secrets;
  defaultAccess = { mode = "0600"; }; # user only
  rootOnlyAccess = { mode = "0600"; owner = "root"; }; # root only
  noAccess = { mode = "0000"; };

  # common secrets
  initialLoginPass = {
    sops.secrets = {
      "login/initialHashedPassword" = {
        sopsFile = "${inputs.secrets}/login.enc.yaml";
      } // rootOnlyAccess;
    };
  };
in
{
  options.modules.secrets = {
    workstation = {
      # home secrets
      home.enable = mkEnableOption "Home secrets for workstation";
      system.enable = mkEnableOption "System secrets for workstation";
    };

    server = {
      system.base.enable = mkEnableOption "System secrets for network servers";
      # system.network.enable = mkEnableOption "System secrets for network servers";
      # system.application.enable = mkEnableOption "Secrets for application servers";
      # system.operation.enable = mkEnableOption "Secrets for operation servers (backup, monitoring, etc)";
    };

    # impermanence.enable = mkEnableOption "Wether use impermanence and ephemeral root file system";
  };

  config = mkIf
    (
      cfg.workstation.home.enable ||
      cfg.workstation.system.enable ||
      cfg.server.system.base.enable
    )
    (
      mkMerge [
        # sops-nix keys configs
        {
          sops = {
            age.keyFile = mkDefault "/var/lib/age/age-yubikey-master.key";
            defaultSopsFormat = mkDefault "yaml";
          };
        }

        # workstation specific secrets
        (mkIf cfg.workstation.home.enable {
          sops.secrets = {
            "minio/config" = {
              sopsFile = "${inputs.secrets}/minio.enc.yaml";
              path = "${config.home.homeDirectory}/.mc/config.json";
            } // defaultAccess;
            "rclone/pikpak" = {
              sopsFile = "${inputs.secrets}/rclone.enc.yaml";
              path = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
            } // defaultAccess;
            "ssh/config" = {
              sopsFile = "${inputs.secrets}/ssh.enc.yaml";
              path = "${config.home.homeDirectory}/.ssh/config";
            } // defaultAccess;
          };
        })

        (mkIf cfg.workstation.system.enable initialLoginPass // {
          sops.secrets = {
            "age/yubikey-master-key" = {
              sopsFile = "${inputs.secrets}/age-keys.enc.yaml";
            } // noAccess;
            "samba/qnap" = {
              sopsFile = "${inputs.secrets}/samba.enc.yaml";
              path = "/etc/.smbcredentials";
            } // rootOnlyAccess;
          };
        })

        # server specific secrets
        (mkIf cfg.server.system.base.enable initialLoginPass)
      ]
    );
}
