{ pkgs-stable, ... }:

{
  home.packages = with pkgs-stable; [
    mountpoint-s3 # A simple, high-throughput file client for mounting an Amazon S3 bucket as a local file system.
  ];
}
