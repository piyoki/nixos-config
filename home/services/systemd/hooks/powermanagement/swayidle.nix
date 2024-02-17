{ inputs, pkgs, system, ... }:

# $HOME/.config/systemd/user/swayidle.service
let
  swayidleBin = inputs.nixpkgs-wayland.packages.${system}.swayidle;
  swBin = "/run/current-system/sw/bin";
in
{
  # enable swayidle
  systemd.user.services."swayidle" = {
    Unit = {
      Description = "Idle manager for Wayland";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "lockscreen" ''
        set -eux
        ${swayidleBin}/bin/swayidle -w \
          timeout 300 'swaylock -f' \
          timeout 360 'hyprctl dispatch dpms off' \
          resume 'hyprctl dispatch dpms on' \
          before-sleep 'swaylock -f'
      ''}";
      ExecStartPost = "${swBin}/sleep 1";
      ExecStop = "${pkgs.writeShellScript "lockscreen" ''
        set -eux
        ${swBin}/pkill swayidle
        ${swBin}/pkill swaylock
      ''}";

      Type = "oneshot";
      Environment = [
        "PATH=$PATH:/run/current-system/sw/bin"
      ];
    };
  };
}
