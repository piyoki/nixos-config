{ lib, ... }:

{
  config = {
    allowUnfree = lib.mkDefault true;
    permittedInsecurePackages = [
      "ventoy-1.1.07"
      "qtwebengine-5.15.19"
    ];
  };
}
