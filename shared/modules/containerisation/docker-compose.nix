{ pkgs, lib, config, ... }:

with lib;
# References:
# https://discourse.nixos.org/t/running-a-docker-compose-file-automatically/24663/7
let
  cfg = config.modules.docker-compose;
in
{
  options.modules.docker-compose = {
    enable = mkEnableOption "Run docker-compose as a systemd unit service";
    service = mkOption {
      type = types.str;
      default = "docker-compose";
      description = "name of the docker-compose service";
    };
    description = mkOption {
      type = types.str;
      default = "";
      description = "description of the docker-compose service";
    };
    composePath = mkOption {
      type = types.str;
      default = "";
      description = "path of the docker-compose file";
    };
    environment = mkOption {
      type = types.listOf types.str;
      default = "";
      description = "list of environment variables";
    };
  };

  config = mkIf cfg.enable (
    mkMerge [
      {
        # systemd service
        systemd.services.${cfg.service} = {
          wantedBy = [ "multi-user.target" ];
          after = [ "docker.service" "docker.socket" ];
          inherit (cfg) description;
          serviceConfig = {
            ExecStart = "${pkgs.writeShellScript "${cfg.service}" ''
              set -eux
              ${pkgs.docker}/bin/docker compose up -f ${cfg.path} -d
            ''}";
            Type = "simple";
            Environment = [ "PATH=$PATH:${swBin}" ] ++ cfg.environment;
          };
        };
      }
    ]
  );
}
