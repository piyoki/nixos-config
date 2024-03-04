{ inputs, ... }:

{
  sops.secrets = {
    "age/yubikey-master-key" = {
      sopsFile = "${inputs.secrets}/age-keys.enc.yaml";
      mode = "0644";
    };
  };
}
