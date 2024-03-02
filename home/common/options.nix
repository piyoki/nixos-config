{ lib, ... }:

with lib;

# References:
# https://nixos.wiki/wiki/Declaration
# https://www.reddit.com/r/NixOS/comments/wzsz4k/how_can_i_add_some_custom_data_variables_into/
{
  options.common = {
    profile = mkOption {
      type = types.attrs;
      default = {
        type = types.str;
        default = "laptop";
        description = "host profile";
      };
      description = "host profile";
    };
  };
}
