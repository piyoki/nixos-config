{ user, ... }:

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

          {
            directory = ".gnupg";
            mode = "0700";
          }
          {
            directory = ".ssh";
            mode = "0700";
          }
          {
            directory = "flake";
            mode = "0700";
          }
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
