{ inputs, lib, system, ... }:

let
  configDir = "/etc/dae";
in
{
  imports = [
    inputs.daeuniverse.nixosModules.dae
  ];

  # sdwan
  environment.systemPackages = with inputs.daeuniverse.packages.${system}; [ dae ];

  services.dae = {
    enable = true;
    disableTxChecksumIpGeneric = false;
    configFile = "${configDir}/config.dae";
    assetsPath = configDir;
    openFirewall = {
      enable = true;
      port = 12345; # tproxy
    };
  };

  # do not enable the service at startup
  systemd.services.dae.wantedBy = lib.mkForce [ ];
}
