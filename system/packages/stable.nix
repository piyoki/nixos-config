{ pkgs-stable, ... }:

{
  # ebpf
  environment.systemPackages = with pkgs-stable; [
    tailspin # A log file highlighter
  ];
}
