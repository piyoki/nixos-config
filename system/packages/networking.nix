{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dnsutils # Domain name server tools
    traceroute # Tracks the route taken by packets over an IP network
    lsof # Tool to list open files
    tcpdump # Network sniffer
  ];
}
