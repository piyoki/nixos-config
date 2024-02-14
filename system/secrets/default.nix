_:

{
  imports = [
    ./sdwan.nix
  ];

  # sops-nix
  sops = {
    age.keyFile = "/var/lib/age/age-yubikey-master.key";
    defaultSopsFormat = "yaml";
  };
}
