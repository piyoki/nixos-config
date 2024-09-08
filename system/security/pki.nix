# Reference:
# https://discourse.nixos.org/t/help-adding-a-ca-certificate-with-security-pki-certificatefiles/25131/3

{
  security.pki.certificateFiles = [
    ./tls/hikarilab.me/ecc-ca.crt
  ];
}
