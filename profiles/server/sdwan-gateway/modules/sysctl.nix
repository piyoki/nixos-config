_:

# References:
# https://cloud.tencent.com/developer/article/2141920
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
    "net.ipv4.tcp_syn_retries" = 2;
    "net.ipv4.tcp_synack_retries" = 2;
    "net.ipv4.tcp_timestamps" = 1;
    "net.ipv4.tcp_fin_timeout" = 30;
    "net.ipv4.tcp_keepalive_time" = 1200;
    "net.ipv4.tcp_max_syn_backlog" = 8192;
    "net.ipv4.tcp_max_tw_buckets" = 5000;
  };
}
