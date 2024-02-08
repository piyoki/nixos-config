{ config, ... }:

{
  # $HOME/.mc/config.json
  # home.file.".mc/config.json".text = ''
  #   {
  #     "host": ${config.sops.secrets."minio/host".path}
  #   }
  # '';
}
