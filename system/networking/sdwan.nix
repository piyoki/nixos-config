{ inputs, system, ... }:

{
  # sdwan
  environment.systemPackages = with inputs.daeuniverse.packages.${system}; [ dae ];

  services.dae = {
    enable = false;
    disableTxChecksumIpGeneric = false;
    configFile = "/etc/dae/config.dae";
    openFirewall = {
      enable = true;
      port = 12345; # tproxy
    };
  };
}
