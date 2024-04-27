{ lib, ... }:

# A key remapping daemon for linux.
# Reference: https://github.com/rvaiya/keyd
{
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        # Remaps the capslock key to control
        capslock = "oneshot(control)";
        # Remaps the meta key to alt
        meta = "oneshot(alt)";
        # Remaps the leftalt key to meta
        leftalt = "oneshot(meta)";

        # Maps capslock to capslock when pressed and control when held.
        # capslock = "overload(control, capslock)";
      };
    };
  };

  # disable systemd service
  systemd.services.keyd.wantedBy = lib.mkForce [ ];
}
