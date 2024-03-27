{ inputs, pkgs, system, ... }:

{
  home.packages = with pkgs; [
    (inputs.pilots.packages.${system}.qutebrowser_nightly.overrideAttrs {
      enableWideVine = true;
      enableVulkan = true;
    })
  ];
}
