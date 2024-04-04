{
  hostCommonConfig = ''
    encode zstd gzip
    tls "/etc/caddy/tls/ecc_server.crt" "/etc/caddy/tls/ecc_server.key" {
      protocols tls1.3 tls1.3
      curves x25519 secp384r1 secp521r1
    }
  '';
}
