{ inputs, pkgs, config, system, ... }:

# $HOME/.config/systemd/user/swayidle.service
let
  swayidleBin = inputs.nixpkgs-wayland.packages.${system}.swayidle;
  swaylockBin = inputs.nixpkgs-wayland.packages.${system}.swaylock-effects;
  swBin = "/run/current-system/sw/bin";
in
{
  # enable swayidle
  systemd.user.services."swayidle" = {
    Unit = {
      Description = "Idle manager for Wayland";
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "lockscreen" ''
        set -eux
        ${swayidleBin}/bin/swayidle -w \
          timeout 300 '${swaylockBin}/bin/swaylock -f' \
          timeout 360 'hyprctl dispatch dpms off' \
          resume 'hyprctl dispatch dpms on' \
          before-sleep 'unmount-samba && ${swaylockBin}/bin/swaylock -f'
      ''}";
      ExecStartPost = "${swBin}/sleep 1";
      ExecStop = "${pkgs.writeShellScript "lockscreen" ''
        set -eux
        ${swBin}/pkill swayidle
        ${swBin}/pkill swaylock
      ''}";
      RemainAfterExit = "yes";
      Type = "oneshot";
      Environment = [
        "PATH=$PATH:/run/current-system/sw/bin:${config.home.homeDirectory}/.local/scripts"
      ];
    };
  };
}
