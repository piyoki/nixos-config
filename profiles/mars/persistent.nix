{ user, ... }:

{
  environment.persistence."/nix/persistent" = {
    hideMounts = true;

    # directories to map
    directories = [
      "/etc/NetworkManager/system-connections"
      "/root"
      "/var"
    ];

    # files to map
    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
    ];

    # 类似的，你还可以在用户的 home 目录中单独映射文件和文件夹
    # home dirs and files to map
    users.${user} = {
      directories = [
        # home dirs
        "flake"

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
      ];

      files = [ ];
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

  # force to trigger nix daemon; make the above configuration work for root user
  environment.variables.NIX_REMOTE = "daemon";
}
