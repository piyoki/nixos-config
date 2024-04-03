{ inputs, ... }:

{
  security.pki.certificateFiles = [
    (inputs.home-estate + "/tls/homelab.sh/ca.crt")
  ];
}
