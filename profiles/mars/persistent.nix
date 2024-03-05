{ user, ... }:

let
  mode = "0700";
in
{
  environment = {
    # force to trigger nix daemon; make the above configuration work for root user
    variables.NIX_REMOTE = "daemon";

    persistence."/persistent" = {
      hideMounts = true;

      # directories to map
      directories = [
        "/etc/NetworkManager/system-connections"
        "/root"
        "/var"
        "/etc/ssh"
      ];

      # files to map
      files = [
        "/etc/machine-id"
      ];

      # home dirs and files to map
      users.${user} = {
        directories = [
          # home dirs
          "tmp"

          # config dirs
          ".cache"
          ".config"
          ".local"

          { directory = ".sops"; inherit mode; }
          { directory = ".gnupg"; inherit mode; }
          { directory = ".ssh"; inherit mode; }
          { directory = ".tmux"; inherit mode; }
          { directory = "flake"; inherit mode; }
        ];

        files = [
          ".gitconfig"
        ];
      };
    };
  };

  systemd.services.nix-daemon = {
    environment = {
      # Specify tmpdir
      TMPDIR = "/var/cache/nix";
    };
    serviceConfig = {
      # create /var/cache/nix when nix daemon starts
      CacheDirectory = "nix";
    };
  };
}
