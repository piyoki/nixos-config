{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # misc
    brightnessctl
    cifs-utils
    dmidecode
    libnotify
    libva-utils # A collection of utilities and examples for VA-API
  ];
}
