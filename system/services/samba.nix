{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  # Samba client
  # reference: https://nixos.wiki/wiki/Samba
  # fileSystems."/mnt/share/Tank" = {
  #   options = let
  #     device = "//10.178.0.81/Tank";
  #     fsType = "cifs";
  #     opts = "iocharset=utf8";
  #     credentials = "/home/kev/.smbcredentials";

  #     in ["${opts},credentials=${credentials},uid=1000,gid=100"];
  # };
}

