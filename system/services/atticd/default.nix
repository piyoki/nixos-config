{ inputs, ... }:

# References:
# https://github.com/zhaofengli/attic
# https://docs.attic.rs/tutorial.html

# NOTES:
# --- atticd (atticadm) ---
# [make-token]
# sudo atticd-atticadm make-token --sub kev --pull dev --push dev  --create-cache dev --validity "10y"
# --- attic-client ---
# [login]
# attic login --set-default default [SERVER_ENDPOINT] [TOKEN]
# [create cache]
# attic cache create [CACHE_NAME]
# [push]
# attic push [CACHE_NAME] [NIX_STORE_PATH]
{
  imports = [ inputs.attic.nixosModules.atticd ];

  services.atticd = {
    enable = true;

    # Replace with absolute path to your credentials file
    credentialsFile = "/etc/atticd/env";

    settings = {
      listen = "[::]:8080";
      # Database
      database.url = "postgresql://attic:attic@localhost:5432/attic";
      # api-endpoint = "";
      # Data chunking
      # Warning: If you change any of the values here, it will be
      # difficult to reuse existing chunks for newly-uploaded NARs
      # since the cutpoints will be different. As a result, the
      # deduplication ratio will suffer for a while after the change.
      chunking = {
        # The minimum NAR size to trigger chunking
        #
        # If 0, chunking is disabled entirely for newly-uploaded NARs.
        # If 1, all NARs are chunked.
        nar-size-threshold = 64 * 1024; # 64 KiB

        # The preferred minimum size of a chunk, in bytes
        min-size = 16 * 1024; # 16 KiB

        # The preferred average size of a chunk, in bytes
        avg-size = 64 * 1024; # 64 KiB

        # The preferred maximum size of a chunk, in bytes
        max-size = 256 * 1024; # 256 KiB
      };
      # Backend storage
      storage = {
        type = "s3";
        region = "ap-east-1";
        bucket = "atticd";
        endpoint = "http://10.178.0.81:9000";
      };
    };
  };

  # open ports in firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8080 ];
  };
}
