{ pkgs, user, ... }:

# References:
# https://nixos.wiki/wiki/Docker
{
  # enable docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  users.extraGroups.docker.members = [ user ];

  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    docker-compose # start group of containers for dev
    lazydocker # Docker terminal UI.
  ];
}
