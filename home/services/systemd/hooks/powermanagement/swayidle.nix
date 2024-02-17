{ inputs, pkgs, system, ... }:

# $HOME/.config/systemd/user/swayidle.service
let
  swayidleBin = inputs.nixpkgs-wayland.packages.${system}.swayidle;
in
{
  # auto lockscreen
  systemd.user.services."swayidle" = {
    Unit = {
      Description = "Idle manager for Wayland";
    };
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "lockscreen" ''
        set -eux
        ${swayidleBin}/bin/swayidle -w \
          timeout 300 'swaylock -f' \
          timeout 600 'hyprctl dispatch dpms off' \
          resume 'hyprctl dispatch dpms on' \
          before-sleep 'swaylock -f'
      ''}";
      ExecStartPost = "/run/current-system/sw/bin/sleep 1";
      Type = "simple";
      Environment = [
        "PATH=$PATH:/run/current-system/sw/bin"
      ];
    };
  };
}
