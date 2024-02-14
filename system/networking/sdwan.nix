{ inputs, system, ... }:

let
  configDir = "/etc/dae";
in
{
  # sdwan
  environment.systemPackages = with inputs.daeuniverse.packages.${system}; [ dae ];

  services.dae = {
    enable = false;
    disableTxChecksumIpGeneric = false;
    configFile = "${configDir}/config.dae";
    assetsPath = configDir;
    openFirewall = {
      enable = true;
      port = 12345; # tproxy
    };
  };
}
