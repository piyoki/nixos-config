{ inputs, ... }:

{
  security.pki.certificateFiles = [
    (inputs.home-estate + "/tls/homelab.local/ecc-fullchain.crt")
  ];
}
