_:

{
  # Environment vars
  environment = {
    # system-level variables
    variables = {
      # set vim as the default editor
      EDITOR = "nvim";
    };

    # session-specfic variables
    sessionVariables = {
      # Nix specific
      NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
      # Wayland specific
      NIXOS_OZONE_WL = "1";
      # Default applications
      BROWSER = "firefox";
      # Force intel-media-driver
      LIBVA_DRIVER_NAME = "iHD";
    };
  };
}
