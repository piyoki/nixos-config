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
    # apply throughput tweaks
    "net.ipv4.tcp_tw_reuse" = 1;
    "net.ipv4.tcp_tw_recycle" = 1;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_syn_retries" = 1;
    "net.ipv4.tcp_synack_retries" = 1;
    "net.ipv4.tcp_timestamps" = 1;
    "net.ipv4.tcp_fin_timeout" = 30;
  };
}
