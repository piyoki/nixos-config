# References:
# https://github.com/chaotic-cx/nyx/issues/460
# https://github.com/sched-ext/scx

# Debug:
# check if the correct kernel booted:
# ╰─λ zgrep 'SCHED_CLASS' /proc/config.gz
# CONFIG_SCHED_CLASS_EXT=y
# start a scheduler:
# ╰─λ sudo scx_rusty
# 21:38:53 [INFO] CPUs: online/possible = 24/32
# 21:38:53 [INFO] DOM[00] cpumask 00000000FF03F03F (20 cpus)
# 21:38:53 [INFO] DOM[01] cpumask 0000000000FC0FC0 (12 cpus)
# 21:38:53 [INFO] Rusty Scheduler Attached

{ pkgs, ... }:

{
  # --- Legacy Configuration ---
  # A Linux kernel feature which enables implementing kernel thread schedulers in BPF and dynamically loading them.
  # environment.systemPackages = [ bin ];

  # systemd unit
  # /etc/systemd/system/scx.service
  # systemd.services."scx" = {
  #   description = "Start scx_scheduler";
  #   documentation = [ "https://github.com/sched-ext/scx" ];
  #   serviceConfig = {
  #     ExecStart = "${pkgs.writeShellScript "scx" ''
  #       set -eux
  #       ${bin}/bin/scx_bpfland
  #     ''}";
  #     Type = "simple";
  #     StandardError = "journal";
  #     LogNamespace = "sched-ext";
  #     Restart = "always";
  #     Environment = [ ];
  #   };
  #   wantedBy = [ "multi-user.target" ];
  # };

  # --- New Configuration ---
  services.scx = {
    enable = true;
    package = pkgs.scx.full;
    # one of "scx_bpfland", "scx_central", "scx_flatcg", "scx_lavd", "scx_layered", "scx_nest", "scx_pair", "scx_qmap", "scx_rlfifo", "scx_rustland", "scx_rusty", "scx_simple", "scx_userland"
    scheduler = "scx_bpfland";
  };
}
