{ inputs, user, lib, ... }:

let
  mode = "0700";
  genSpecialDir = directory: { inherit directory mode; };
in
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    ./nix-daemon.nix
  ];

  environment = {
    persistence."/persistent" = {
      hideMounts = true;

      # directories to map
      directories = lib.mkDefault (import ./dirs/common-system-dirs.nix);

      # files to map
      files = lib.mkDefault [
        "/etc/machine-id"
      ];

      # home dirs and files to map
      users.${user} = {
        directories = lib.mkDefault ((import ./dirs/common-home-dirs.nix) ++ [
          (genSpecialDir "flake")
          (genSpecialDir ".gnupg")
          (genSpecialDir ".ssh")
        ]);

        files = lib.mkDefault [
          ".gitconfig"
        ];
      };
    };
  };
}
