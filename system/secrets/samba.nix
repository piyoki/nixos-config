{ inputs, ... }:

{
  sops.secrets = {
    "samba/qnap" = {
      sopsFile = "${inputs.secrets}/samba.enc.yaml";
      mode = "0600";
      path = "/etc/.smbcredentials";
    };
  };
}
