{ nixpkgs, ... }:

{
  config.packageOverrides = pkgs: {
    vaapiIntel = nixpkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
}
