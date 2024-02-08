{ ... }:

{
  # sops-nix configs
  sops = {
    # sops-nix configs
    age.keyFile = "/var/lib/age/age-yubikey-master.key";
    defaultSopsFormat = "yaml";

    # secrets
    secrets = {
      "minio/host" = {
        sopsFile = ../../secrets/config.enc.yaml;
      };
      "minio/accessKey" = {
        sopsFile = ../../secrets/config.enc.yaml;
      };
      "minio/secretKey" = {
        sopsFile = ../../secrets/config.enc.yaml;
      };
    };
  };
}
