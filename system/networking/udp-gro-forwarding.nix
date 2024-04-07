{ pkgs, ... }:

# Optimize UDP throughput
# Reference: https://tailscale.com/kb/1320/performance-best-practices#ethtool-configuration
let
  swBin = "/run/current-system/sw/bin";
in
{
  environment.systemPackages = with pkgs; [
    ethtool
  ];

  # /etc/systemd/system/udp-gro-forwarding.service
  systemd.services."udp-gro-forwarding" = {
    description = "UDP Gro Forwarding Service";
    after = [ "network.target" "iptables.service" "ip6tables.service" "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.writeShellScript "udp-gro-forwarding" ''
        set -eux
        NETDEV=$(${swBin}/ip route show 0/0 | grep 'via' | cut -f5 -d ' ')
        ${pkgs.ethtool}/bin/ethtool -K $NETDEV rx-udp-gro-forwarding on rx-gro-list off;
      ''}";
      Type = "oneshot";
      Environment = [ "PATH=$PATH:${swBin}" ];
    };
    wantedBy = [ "multi-user.target" ];
  };
}
