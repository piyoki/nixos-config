{ pkgs, ... }:

let
  user = (import ../../vars.nix).user;
in
{
  users = {
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4YpotphfZittW6FZDI0phTUra708NiCay08aK3Nm3asNXF+OGggUljDcXZDR9yiVj7CdPqq67qH1ce1AaALz5KmT8j91InyHf4Rd+doy0MaLxl3lFqAma5cXU6UXXdScN3xlUE92NXNPsZiEVT5K6QVXoz0qGdEb1ptxKMou3zw6mat04KOpXfTNwJQEapSjpq6yDNamjmRyiOFZbXeTiqAYihXv9sfCbtdWgBryK7lqr7IkByT2wqaEmxXQg+eQoZuN8gFgxWxVNTE62KsM+9JIz6gvEB37x3pdJeip260yusNez0rzSTts+l2SO2+nNn3Fc18RHFGyvbqB29K+Tt6/LhHIxcGwyQhgOQY3KAWugOUWNkWyqW8zEHM4a2p5K+VtBFin2cSBwN4HO4pxVYsHW3MxK3fg4iPB/LkyR+MvAPCLP1eVNP3zy7t5J7ZUZdoBcIeGP6Hl70jvhptJla0x5w1ixIthkj3qAikiXscLJ9Jm8MChEiVzRWGwJhOgoCsnsiN4udvCQ4oQUW3K3zVpKmHtOsbNNZKQGXQOB3zxBd7qHNj+6ktL9/WdxWXWMkfG9mB1nS/+wNl0vSOhV9WxCzXQh8QzmiDcX+rEuMXjz4DD2QZ0bgOFSBwaJ9wyVUqylRj9B1EgjiL1ouU6fY/FPJDXbOhPV+XQ7viSAlQ== cardno:17 117 053" ];
      packages = with pkgs; [];
    };

    users.root = {
      shell = pkgs.bash;
    };
  };
}

