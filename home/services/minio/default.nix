{ config, ... }:

{
  # $HOME/.mc/config.json
  home.file.".mc/config.json".text = ''
    {
      "host": ${builtins.readFile "${secretPath}/minio/host"}
    }
  '';
}
