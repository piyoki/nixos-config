{ ... }:

{
  services = {
    # openssh daemon
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false; # disable SSH password log in
    };
  };

  programs = {
    # gnupg-agent
    gnupg = {
      agent = {
        enable = false;
        pinentryFlavor = "curses";
        enableSSHSupport = true;
      };
    };
    fish.enable = true;
    hyprland.enable = true;
  };

  # zramd
  zramSwap.enable = true;

  # docker
  virtualisation.docker.enable = true;
}
