{ lib, ... }:

{
  config = {
    allowUnfree = lib.mkDefault true;
  };
}
