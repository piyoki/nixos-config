{ lib, ... }:

with lib;

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
