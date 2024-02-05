{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ccid # ccid drivers for pcsclite
    gnupg
    libfido2
    libu2f-host
    libusb-compat-0_1
    opensc # Set of libraries and utilities to access smart cards
    pam_u2f
    pcsctools # Tools used to test a PC/SC driver, card or reader
    pinentry # GnuPG’s interface to passphrase input
    yubico-pam
    yubikey-personalization
  ];

  services.udev.packages = with pkgs; [
    libu2f-host
    yubikey-personalization
  ];

  # enable pcscd
  services.pcscd.enable = true;

  programs = {
    # gnupg-agent
    gnupg = {
      agent = {
        enable = true;
        pinentryFlavor = "curses";
        enableSSHSupport = true;
      };
    };
  };
}


