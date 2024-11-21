{ pkgs-stable, ... }:

{
  home.packages = with pkgs-stable; [
    # media
    cava # for visualizing audio

    # productivity
    mountpoint-s3 # A simple, high-throughput file client for mounting an Amazon S3 bucket as a local file system.
  ];
}
