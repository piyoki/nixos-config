_:

{
  imports = [
    ../../../../system/secrets/init-pass.nix
  ];

  # sops-nix
  sops = {
    age.keyFile = "/var/lib/age/age-yubikey-master.key";
    defaultSopsFormat = "yaml";
  };
}
