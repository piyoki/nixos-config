{ lib, pkgs, ... }:

# References:
# https://nixos.wiki/wiki/ALSA
{
  environment.systemPackages = with pkgs; [
    pavucontrol
    pamixer
    sof-firmware
  ];

  # Only meant for ALSA-based configurations
  sound.enable = false;

  # Disable Pulseaudio because Pipewire is used
  hardware.pulseaudio.enable = lib.mkForce false;

  # Enable pipewire, alsa, and jack
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber = {
      enable = true;
      package = pkgs.wireplumber;
    };
  };
}
