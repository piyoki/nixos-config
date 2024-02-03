{ inputs, system, user, ... }:


let
  homeProfile = ./home.nix;
in
{
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
