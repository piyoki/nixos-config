{ config, ... }:

{
  # auto reload sops-nix systemd service
  home.activation.setupEtc = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    run /run/current-system/sw/bin/systemctl start --user sops-nix
  '';
}
