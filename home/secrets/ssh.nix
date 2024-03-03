{ inputs, config, ... }:

{
  sops.secrets = {
    "ssh/config" = {
      sopsFile = "${inputs.secrets}/ssh.enc.yaml";
      mode = "0600";
      path = "${config.home.homeDirectory}/.ssh/config";
    };
  };
}
