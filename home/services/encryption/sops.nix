{ inputs, pkgs, lib, ... }:

{
  home = {
    packages = with pkgs; [
      sops # Simple and flexible tool for managing secrets
      age # Modern encryption tool with small explicit keys
    ];
  };

  # sops-nix
  sops = {
    age.keyFile = lib.mkDefault "/var/lib/age/age-yubikey-master.key";
    defaultSopsFormat = "yaml";
  };

  home = {
    file = {
      # sops
      ".sops/.sops.yaml".text = "${inputs.secrets}/.sops.yaml";
    };
  };
}
