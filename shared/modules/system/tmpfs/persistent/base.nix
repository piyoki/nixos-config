{ user, ... }:

let
  mode = "0700";
  genSpecialDir = directory: { inherit directory mode; };
in
{
  imports = [
    ./nix-daemon.nix
  ];

  environment = {
    persistence."/persistent" = {
      hideMounts = true;

      # directories to map
      directories = import ./dirs/common-system-dirs.nix;

      # files to map
      files = [
        "/etc/machine-id"
      ];

      # home dirs and files to map
      users.${user} = {
        directories = (import ./dirs/common-home-dirs.nix) ++ [
          (genSpecialDir "flake")
          (genSpecialDir ".gnupg")
          (genSpecialDir ".ssh")
        ];

        files = [
          ".gitconfig"
        ];
      };
    };
  };
}
