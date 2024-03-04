{ pkgs, ... }:

# Reference: https://nixos.wiki/wiki/Yubikey
{
  environment.systemPackages = with pkgs; [
    ccid # ccid drivers for pcsclite
    libfido2
    libu2f-host
    libusb-compat-0_1
    opensc # Set of libraries and utilities to access smart cards
    pam_u2f
    pcsctools # Tools used to test a PC/SC driver, card or reader
    yubico-pam
    yubikey-personalization # A library and command line tool to personalize YubiKeys
  ];

  services = {
    # install necessary udev packages
    udev.packages = with pkgs; [
      libu2f-host
      yubikey-personalization
    ];
    # enable pcscd
    pcscd.enable = true;
  };
}
