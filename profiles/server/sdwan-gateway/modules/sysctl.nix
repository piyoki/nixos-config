_:

{
  boot.kernel.sysctl = {
    # enable bbr
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "fq";
    # enable tcp_fastopen
    "net.ipv4.tcp_fastopen" = 3;
    # enable swapiness
    "vm.swappiness" = 60;
  };
}
