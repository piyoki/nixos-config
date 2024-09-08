{ inputs, ... }:

{
  security.pki.certificateFiles = [
    (inputs.home-estate + "/tls/hikarilab.me/ecc-fullchain.crt")
  ];
}
