{ pkgs, ... }:

# References:
# https://docs.atuin.sh/self-hosting/server-setup/
# https://haseebmajid.dev/posts/2023-08-12-how-sync-your-shell-history-with-atuin-in-nix/
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
