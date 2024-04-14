_:

{
  imports = [
    ./polkit.nix
    ./sudo.nix
    ./intel_gpu_top.nix
    ./pki.nix
  ];

  security = {
    # required by pulseaudio
    rtkit.enable = true;

    # make swaylock unlock with correct password
    pam.services = {
      swaylock = {
        text = ''
          auth include login
        '';
      };

      # enable gnome keyring
      login.enableGnomeKeyring = true;
    };
  };
}
