{ inputs, ... }:

let
  configDir = "/etc/dae";
  mode = "0600";
in
{
  # sdwan
  sops.secrets = {
    "dae/config" = {
      sopsFile = "${inputs.secrets}/dae/config.enc.yaml";
      inherit mode;
      path = "${configDir}/config.dae";
    };
    "dae/modules/dns" = {
      sopsFile = "${inputs.secrets}/dae/modules/dns.enc.yaml";
      inherit mode;
      path = "${configDir}/config.d/dns.dae";
    };
    "dae/modules/route" = {
      sopsFile = "${inputs.secrets}/dae/modules/route.enc.yaml";
      inherit mode;
      path = "${configDir}/config.d/route.dae";
    };
    "dae/modules/node" = {
      sopsFile = "${inputs.secrets}/dae/modules/node.enc.yaml";
      inherit mode;
      path = "${configDir}/config.d/node.dae";
    };
  };
}
