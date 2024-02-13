{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    polkit # policy daemon
    polkit-kde-agent
  ];

  security = {
    polkit.enable = true;
    polkit.debug = true;

    # make swaylock unlocks with correct password
    pam.services.swaylock = { };

    # sudo
    # Reference: https://nixos.wiki/wiki/Sudo
    sudo = {
      enable = true;
      extraRules = [{
        commands = [
          {
            command = "/run/wrappers/bin/umount";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/wrappers/bin/mount";
            options = [ "NOPASSWD" ];
          }
          {
            command = "${pkgs.cifs-utils}/bin/mount.cifs";
            options = [ "NOPASSWD" ];
          }
        ];
        groups = [ "wheel" ];
      }];
    };
  };
}
