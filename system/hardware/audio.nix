{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pavucontrol
    pamixer
  ];

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
