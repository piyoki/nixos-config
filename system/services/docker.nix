{ user, ... }:

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
}
