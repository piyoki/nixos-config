{
  # host profiles
  profiles = {
    workstations = [
      "thinkpad-x1-carbon"
      "nuc-12"
    ];
    servers = [
      "mars"
      "felix"
      "sdwan-gateway"
      "tailscale-gateway"
    ];
    microvms = [
      "firecracker"
    ];
  };
}
