{ pkgs, ... }:

let
  wrapperBin = "/run/wrappers/bin";
  swBin = "/run/current-system/sw/bin";
in
{

  # sudo
  # Reference: https://nixos.wiki/wiki/Sudo
  security.sudo = {
    enable = true;
    extraRules = [{
      commands = [
        # mount related actions
        {
          command = "${wrapperBin}/umount";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${wrapperBin}/mount";
          options = [ "NOPASSWD" ];
        }
        {
          command = "${pkgs.cifs-utils}/bin/mount.cifs";
          options = [ "NOPASSWD" ];
        }
        # system related
        {
          command = "${swBin}/tee";
          options = [ "NOPASSWD" ];
        }
      ];
      groups = [ "wheel" ];
    }];
  };
}
