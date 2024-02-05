{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pavucontrol
    pamixer
  ];

  # Enable audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
