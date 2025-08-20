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
# Tear down permission
# r - 4
# w - 2
# x - 1
# Examples
# 0644 -> rw- r-- r--

# Default home secret path:
# /run/user/1000/secrets/

# Default system secret path:
# /run/secrets/

# Put the master age key in the following path:
# /var/lib/age/age-yubikey-master.key

# Reference: https://github.com/Mic92/sops-nix

with lib;
let
  cfg = config.modules.secrets;
  defaultAccess = { mode = "0600"; }; # user only # root only and ready only
  openAccess = { mode = "0755"; }; # allow others to read
  rootOnlyAccess = { mode = "0600"; owner = "root"; }; # root only
  noAccess = { mode = "0000"; };

  # common secrets
  commonSecrets = {
    "login/initialHashedPassword" = {
      sopsFile = "${inputs.secrets}/login.enc.yaml";
    } // rootOnlyAccess;
  };

  # function to generate nested secrets
  genNestedSecrets = { secretPaths, sopsFile, access }: (
    builtins.mapAttrs
      (_name: value: value // {
        inherit sopsFile;
      } // access)
      (attrsets.mergeAttrsList secretPaths)
  );
in
{
  options.modules.secrets = {
    workstation = {
      kind = mkOption {
        type = types.str;
        default = "desktop";
        description = mdDoc ''
          Workstation kind
        '';
      };
      home.enable = mkEnableOption "Home secrets for workstation";
      system.enable = mkEnableOption "System secrets for workstation";
    };

    server = {
      system.base.enable = mkEnableOption "System secrets for network servers";
      # system.network.enable = mkEnableOption "System secrets for network servers";
      # system.application.enable = mkEnableOption "Secrets for application servers";
      # system.operation.enable = mkEnableOption "Secrets for operation servers (backup, monitoring, etc)";
    };
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
        (mkIf cfg.workstation.home.enable
          {
            sops.secrets = {
              "ssh/config" = { sopsFile = "${inputs.secrets}/ssh.enc.yaml"; path = "${config.home.homeDirectory}/.ssh/config"; } // defaultAccess;
              "minio/config" = { sopsFile = "${inputs.secrets}/minio.enc.yaml"; path = "${config.home.homeDirectory}/.mc/config.json"; } // defaultAccess;
              "rclone/pikpak" = { sopsFile = "${inputs.secrets}/rclone.enc.yaml"; path = "${config.home.homeDirectory}/.config/rclone/rclone.conf"; } // defaultAccess;
              "aws/credentials" = { sopsFile = "${inputs.secrets}/aws.enc.yaml"; path = "${config.home.homeDirectory}/.aws/credentials"; } // defaultAccess;
              "kube/config" = { sopsFile = "${inputs.secrets}/k8s.enc.yaml"; path = "${config.home.homeDirectory}/.kube/config"; } // defaultAccess;
            }
            // genNestedSecrets
              {
                sopsFile = "${inputs.secrets}/nix.enc.yaml";
                access = defaultAccess;
                secretPaths = [
                  { "nix/public_key".path = "${config.xdg.configHome}/nix/public.key"; }
                  { "nix/secret_key".path = "${config.xdg.configHome}/nix/secret.key"; }
                ];
              }
            // genNestedSecrets {
              sopsFile = "${inputs.secrets}/ssh-keys.enc.yaml";
              access = defaultAccess;
              secretPaths = [
                { "ssh_keys/id_rsa_semaphore_pub".path = "${config.home.homeDirectory}/.ssh/id_rsa_semaphore.pub"; }
                { "ssh_keys/id_rsa_yubikey_desktop_pub".path = "${config.home.homeDirectory}/.ssh/id_rsa_yubikey_desktop.pub"; }
                { "ssh_keys/id_rsa_yubikey_laptop_pub".path = "${config.home.homeDirectory}/.ssh/id_rsa_yubikey_laptop.pub"; }
                { "ssh_keys/id_rsa_yubikey_${cfg.workstation.kind}_pub".path = "${config.home.homeDirectory}/.ssh/id_rsa_yubikey.pub"; }
                { "ssh_keys/id_rsa_semaphore_key".path = "${config.home.homeDirectory}/.ssh/id_rsa_semaphore.pub"; }
                { "ssh_keys/id_rsa_s_user_key".path = "${config.home.homeDirectory}/.ssh/id_rsa_s_user"; }
                { "ssh_keys/id_rsa_h_user_key".path = "${config.home.homeDirectory}/.ssh/id_rsa_h_user"; }
              ];
            }
            // genNestedSecrets {
              sopsFile = "${inputs.secrets}/nix.gitconfig.enc.yaml";
              access = defaultAccess;
              secretPaths = [
                { "gitconfig/profile/${cfg.workstation.kind}".path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.personal"; }
                { "gitconfig/profile/work".path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.work"; }
                { "gitconfig/profile/extras".path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.extras"; }
              ];
            };
          })

        (mkIf cfg.workstation.system.enable {
          sops.secrets = {
            # host specific
            inherit (commonSecrets) "login/initialHashedPassword";
            "age/yubikey-master-key" = { sopsFile = "${inputs.secrets}/age-keys.enc.yaml"; } // noAccess;
            "samba/qnap" = { sopsFile = "${inputs.secrets}/samba.enc.yaml"; path = "/etc/.smbcredentials"; } // rootOnlyAccess;

            # application specific
            "atuin/server-config" = { sopsFile = "${inputs.secrets}/atuin.enc.yaml"; } // openAccess;
            "atuin/env" = { sopsFile = "${inputs.secrets}/atuin.enc.yaml"; } // openAccess;
            "tls/hikarilabme/ecc_server_cert" = { sopsFile = "${inputs.secrets}/tls/hikarilab.me.enc.yaml"; } // openAccess;
            "tls/hikarilabme/ecc_server_key" = { sopsFile = "${inputs.secrets}/tls/hikarilab.me.enc.yaml"; } // openAccess;
          };
        })

        # server specific secrets
        (mkIf cfg.server.system.base.enable {
          sops.secrets = {
            inherit (commonSecrets) "login/initialHashedPassword";
          };
        })
      ]
    );
}
