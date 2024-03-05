_:

{
  environment = {
    # force to trigger nix daemon; make the above configuration work for root user
    variables.NIX_REMOTE = "daemon";
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
