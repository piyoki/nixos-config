{ lib, ... }:

with lib;

# References:
# https://nixos.wiki/wiki/Declaration
# https://www.reddit.com/r/NixOS/comments/wzsz4k/how_can_i_add_some_custom_data_variables_into/
let
  genOption = { type, description, default }: mkOption {
    type = types.attrs;
    default = { inherit type description default; };
    inherit description;
  };
in
{
  options.common = {
    profile = genOption {
      type = types.str;
      default = "desktop";
      description = "host profile";
    };
  };
}
