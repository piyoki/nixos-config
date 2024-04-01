_:

let
  secretsDir = ./shared/server/secrets;
  # function to generate nixosSystem profile
  genProfile =
    { hostname
    , home-manager ? false
    , keys ? { }
    }: { inherit hostname home-manager keys; };
in
{
  profiles = {
    workstations = [
      (genProfile { hostname = "thinkpad-x1-carbon"; home-manager = true; })
      (genProfile { hostname = "nuc-12"; home-manager = true; })
    ];
    servers = [
      (genProfile { hostname = "mars"; })
      (genProfile { hostname = "tailscale-gateway"; })
      (genProfile { hostname = "sdwan-gateway"; })
      (genProfile { hostname = "felix"; keys = { inherit (import (secretsDir + "/atuin-server.nix")) "env" "server.toml"; }; })
    ];
    microvms = [
      (genProfile { hostname = "firecracker"; })
    ];
  };
}
