{ inputs, config, ... }:

{
  # sops-nix
  sops = {
    age.keyFile = "/var/lib/age/age-yubikey-master.key";
    defaultSopsFormat = "yaml";
  };

  home = {
    file = {
      # sops
      ".sops/.sops.yaml".text = "${inputs.secrets}/.sops.yaml";
    };

    # auto reload sops-nix systemd service
    activation.setupEtc = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      run /run/current-system/sw/bin/systemctl start --user sops-nix
    '';
  };
}
