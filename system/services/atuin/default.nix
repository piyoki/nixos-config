{ pkgs, ... }:

# References:
# https://docs.atuin.sh/self-hosting/server-setup/
{
  # install package
  environment.systemPackages = with pkgs; [ atuin ];

  # persist configuration
  environment.etc = {
    "atuin/docker-compose.yml" = {
      mode = "0400";
      source = ./conf/docker-compose.yml;
    };
  };

  # open ports in firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8888 ];
  };
}
