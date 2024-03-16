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
    pam.services = {
      swaylock = {
        text = ''
          auth include login
        '';
      };

      # enable gnome keyring
      login.enableGnomeKeyring = true;
    };

    # intel_gpu_top
    wrappers.intel_gpu_top = {
      source = "${pkgs.intel-gpu-tools}/bin/intel_gpu_top";
      owner = "root";
      group = "wheel";
      permissions = "0750";
      capabilities = "cap_perfmon=ep";
    };

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
