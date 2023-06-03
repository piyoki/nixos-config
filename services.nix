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
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    fish.enable = true;
  };
  
  # docker
  virtualisation.docker.enable = true;
}
