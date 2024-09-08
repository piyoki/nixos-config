# References: https://colmena.cli.rs/unstable/features/keys.html
let
  destDir = "/etc/caddy/tls";
  user = "caddy"; # used by caddy only
  group = "users";
  permissions = "0400";
  uploadAt = "pre-activation";
in
{
  "ecc_server.crt" = {
    keyFile = "/run/secrets/tls/hikarilabme/ecc_server_cert";
    inherit destDir user group permissions uploadAt;
  };
  "ecc_server.key" = {
    keyFile = "/run/secrets/tls/hikarilabme/ecc_server_key";
    inherit destDir user group permissions uploadAt;
  };
}
