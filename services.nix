{ ... }:

{
  services = {
    # qemu guest agent
    qemuGuest.enable = true;
    # xorg
    xserver = {
      enable = false;
      autorun = false;
      layout = "us";
      # xkbOptions = "eurosign:e,caps:escape";
    };
    # openssh daemon.
    openssh = {
      enable = true;
      # Disable SSH password log in
      settings.PasswordAuthentication = false;
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
  };

  # docker
  virtualisation.docker.enable = true;
}
