{ pkgs, ... }:

{
  # ebpf
  environment.systemPackages = with pkgs; [
    pwru # eBPF-based Linux kernel networking debugger
  ];
}
