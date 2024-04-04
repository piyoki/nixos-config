_:

# References:
# https://nixos.wiki/wiki/Caddy
{
  services.caddy = {
    enable = true;
    # Reload Caddy instead of restarting it when configuration file changes.
    enableReload = true;
    user = "caddy"; # User account under which caddy runs.
    dataDir = "/var/lib/caddy";
    logDir = "/var/log/caddy";

    # Additional lines of configuration appended to the global config section of the Caddyfile.
    # Refer to https://caddyserver.com/docs/caddyfile/options#global-options for details on supported values.
    globalConfig = ''
      http_port    80
      https_port   443
      auto_https   disable_certs
    '';
  };

  # Create Directories
  systemd.tmpfiles.rules = [
    "d /var/lib/caddy/fileserver/ 0755 caddy caddy"
    # directory for virtual machine's images
    "d /var/lib/caddy/fileserver/vms 0755 caddy caddy"
  ];
}
