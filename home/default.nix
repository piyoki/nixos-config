{ inputs, system, user, ... }:


let
  homeProfile = ./home.nix;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops.secrets.foo = {
    sopsFile = ./foo.enc.yml;
    format = "yaml";
  };
  sops.gnupg.home = "/var/lib/sops";
  # disable importing host ssh keys
  sops.gnupg.sshKeyPaths = [];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = {
      imports = [
        homeProfile
      ];
    };
    extraSpecialArgs = { inherit inputs system user; };
  };
}
