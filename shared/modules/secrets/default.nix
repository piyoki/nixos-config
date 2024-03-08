{ inputs, lib, config, ... }:

with lib;
let
  cfg = config.modules.secrets;
  defaultAccess = { mode = "0600"; };
  noAccess = { mode = "0000"; };
in
{
  imports = [ ];

  options.modules.secrets = {
    # home secrets
    home = {
      daily-driver.enable = mkEnableOption "Home secrets for desktop | laptop";
    };

    system = {
      # impermanence.enable = mkEnableOption "Wether use impermanence and ephemeral root file sytem";
      daily-driver.enable = mkEnableOption "System secrets for desktop | laptop";
    };

    # server = {
    #   network.enable = mkEnableOption "Secrets for network servers";
    #   application.enable = mkEnableOption "Secrets for application servers";
    #   operation.enable = mkEnableOption "Secrets for operation servers (backup, monitoring, etc)";
    # };
  };

  config = mkIf
    (
      cfg.home.daily-driver.enable ||
      cfg.system.daily-driver.enable
    )
    (
      mkMerge [
        # sops-nix keys configs
        {
          sops = {
            age.keyFile = "/var/lib/age/age-yubikey-master.key";
            defaultSopsFormat = "yaml";
          };
        }

        (mkIf (cfg.home.daily-driver.enable) {
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

        (mkIf (cfg.system.daily-driver.enable) {
          sops.secrets = {
            "age/yubikey-master-key" = {
              sopsFile = "${inputs.secrets}/age-keys.enc.yaml";
            } // noAccess;
          };
          sops.secrets = {
            "samba/qnap" = {
              sopsFile = "${inputs.secrets}/samba.enc.yaml";
              path = "/etc/.smbcredentials";
            } // defaultAccess;
          };
          sops.secrets = {
            "login/initialHashedPassword" = {
              sopsFile = "${inputs.secrets}/login.enc.yaml";
            } // defaultAccess;
          };
        })
      ]
    );
}
