{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # system call monitoring
    strace # system call monitoring
    bpftrace # powerful tracing tool
    tcpdump # network sniffer
    lsof # list open files
  ];
}
