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
      # Fix Wayland VRR issues since kernel 6.11.0+
      # Ref: https://gitlab.freedesktop.org/drm/amd/-/issues/2186
      WLR_DRM_NO_ATOMIC = 1;
    };
  };
}
