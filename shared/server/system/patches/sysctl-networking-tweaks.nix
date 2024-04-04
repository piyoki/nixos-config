_:

# References:
# https://cloud.tencent.com/developer/article/2141920
# https://github.com/3ayonara/LinuxTools/blob/main/Network/BBR/sysctl.conf
# https://wiki.archlinux.org/title/sysctl (Recommended)
# https://wiki.archlinuxcn.org/zh-hk/Sysctl
{
  boot.kernel.sysctl = {
    # discourage Linux from swapping idle processes to disk (default = 60)
    "vm.swappiness" = 10;

    # enable ip_forward
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
    # enable bbr
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "fq";
    # enable tcp_fastopen
    "net.ipv4.tcp_fastopen" = 3;
    # increase ephermeral IP ports
    "net.ipv4.ip_local_port_range" = "10000 65000";

    # increase Linux autotuning TCP buffer limits
    # set max to 16MB for 1GE and 32M (33554432) or 54M (56623104) for 10GE
    # don't set tcp_mem itself! Let the kernel scale it based on RAM.
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    "net.core.rmem_default" = 16777216;
    "net.core.wmem_default" = 16777216;
    "net.core.optmem_max" = 65536;
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    "net.ipv4.udp_rmem_min" = 8192;
    "net.ipv4.udp_wmem_min" = 8192;

    # make room for more TIME_WAIT sockets due to more clients,
    # and allow them to be reused if we run out of sockets
    # increase the max packet backlog
    "net.core.netdev_max_backlog" = 16384;
    "net.ipv4.tcp_max_syn_backlog" = 8192;
    "net.ipv4.tcp_max_tw_buckets" = 5000;
    "net.ipv4.tcp_tw_reuse" = 1;
    "net.ipv4.tcp_fin_timeout" = 10;

    # disable TCP slow start on idle connections
    "net.ipv4.tcp_slow_start_after_idle" = 0;

    # extend max connections entries
    "net.core.somaxconn" = 8192;

    # enable mtu probing
    "net.ipv4.tcp_mtu_probing" = 1;

    # enable reverse path filtering
    # the kernel will do source validation of the packets received from all the interfaces on the machine.
    # this can protect from attackers that are using IP spoofing methods to do harm.
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;

    # prevent sync or udp flood attacks
    # "net.ipv4.tcp_syncookies" = 1;

    # keepalive related tweaks
    # with the following settings, your application will detect dead TCP connections after 1800 seconds (1200s + 125s + 125s + 125s + 125s).
    # "net.ipv4.tcp_keepalive_time" = 1200;
    # "net.ipv4.tcp_keepalive_intvl" = 125;
    # "net.ipv4.tcp_keepalive_probes" = 4;
  };
}
