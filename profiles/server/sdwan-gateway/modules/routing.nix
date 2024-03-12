_:

let
  routeConfigs = { prefixLength = 24; via = "10.20.0.4"; };
in
{
  # routing
  networking.interfaces.ens19.ipv4.routes = [
    # LAG
    { address = "10.178.0.0"; inherit (routeConfigs) prefixLength via; }
    # LAN
    { address = "10.10.10.0"; inherit (routeConfigs) prefixLength via; }
    # APPLICATION subnets
    { address = "10.118.20.0"; inherit (routeConfigs) prefixLength via; }
    { address = "10.118.23.0"; inherit (routeConfigs) prefixLength via; }
    { address = "10.118.25.0"; inherit (routeConfigs) prefixLength via; }
    # CLUSTER subnets
    { address = "10.140.40.0"; inherit (routeConfigs) prefixLength via; }
    # IOT subnets
    { address = "10.169.50.0"; inherit (routeConfigs) prefixLength via; }
    # HOME subnets
    { address = "10.172.69.0"; inherit (routeConfigs) prefixLength via; }
    { address = "10.172.77.0"; inherit (routeConfigs) prefixLength via; }
    # PROXY subnets
    { address = "10.189.17.0"; inherit (routeConfigs) prefixLength via; }
    { address = "10.189.18.0"; inherit (routeConfigs) prefixLength via; }
    # DMZ subnets
    { address = "10.199.99.0"; inherit (routeConfigs) prefixLength via; }
    { address = "10.200.0.0"; inherit (routeConfigs) prefixLength via; }
  ];
}
