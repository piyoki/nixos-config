_:

{
  imports = [
    ./age-keys.nix
    ./samba.nix
    # ./sdwan.nix
  ];

  # sops-nix
  sops = {
    age.keyFile = "/var/lib/age/age-yubikey-master.key";
    defaultSopsFormat = "yaml";
  };
}
