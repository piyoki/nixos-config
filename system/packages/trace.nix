{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # system call monitoring
    strace # system call monitoring
    bpftrace # powerful tracing tool
  ];
}
