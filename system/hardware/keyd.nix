_:

# A key remapping daemon for linux.
# Reference: https://github.com/rvaiya/keyd
{
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        # Maps capslock to capslock when pressed and control when held.
        capslock = "overload(control, capslock)";
      };
    };
  };
}
