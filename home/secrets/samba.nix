{ inputs, config, ... }:

{
  sops.secrets = {
    "samba/qnap" = {
      sopsFile = "${inputs.secrets}/samba.enc.yaml";
      mode = "0600";
      path = "${config.home.homeDirectory}/.smbcredentials";
    };
  };
}
