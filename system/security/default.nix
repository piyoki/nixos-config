{ pkgs, ... }:

let
  wrapperBin = "/run/wrappers/bin";
  swBin = "/run/current-system/sw/bin";
in
{
  environment.systemPackages = with pkgs; [
    polkit # policy daemon
    polkit-kde-agent
  ];

  security = {
    polkit.enable = true;
    polkit.debug = true;
    # required by pulseaudio
    rtkit.enable = true;

    # make swaylock unlocks with correct password
    pam.services.swaylock = { };

    # sudo
    # Reference: https://nixos.wiki/wiki/Sudo
    sudo = {
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
  };
}
