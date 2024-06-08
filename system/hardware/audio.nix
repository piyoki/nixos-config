{ pkgs, ... }:

# References:
# https://nixos.wiki/wiki/ALSA
{
  environment.systemPackages = with pkgs; [
    pavucontrol
    pamixer
  ];

  # Enable sound
  # Save volume state on shutdown
  sound.enable = true;

  # Enable pipewire, alsa, and jack
  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
    };
  };
}
