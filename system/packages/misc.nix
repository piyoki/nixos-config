{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # misc
    brightnessctl
    cifs-utils
    dmidecode
    libnotify
  ];
}
