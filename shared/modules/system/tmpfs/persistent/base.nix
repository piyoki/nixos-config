{ user, ... }:

let
  mode = "0700";
in
{
  imports = [ ./nix-daemon.nix ];

  environment = {
    persistence."/persistent" = {
      hideMounts = true;

      # directories to map
      directories = (import ./dirs/common-system-dirs.nix);

      # files to map
      files = [
        "/etc/machine-id"
      ];

      # home dirs and files to map
      users.${user} = {
        directories = (import ./dirs/common-home-dirs.nix) ++ [
          { directory = "flake"; inherit mode; }
          { directory = ".sops"; inherit mode; }
          { directory = ".gnupg"; inherit mode; }
          { directory = ".ssh"; inherit mode; }
          { directory = ".tmux"; inherit mode; }
        ];

        files = [
          ".gitconfig"
          # ".tmux.conf"
        ];
      };
    };
  };
}
