{ pkgs, lib, ... }:

{
  # Environment vars
  environment = {
    # system-level variables
    variables = {
      # OPENSSL specific
      PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
      LD_LIBRARY_PATH = lib.makeLibraryPath [ pkgs.openssl ];
    };
  };
}
