{ inputs, ... }:

{

  sops.secrets = {
    "login/initialHashedPassword" = {
      sopsFile = "${inputs.secrets}/login.enc.yaml";
      mode = "0600";
    };
  };
}
