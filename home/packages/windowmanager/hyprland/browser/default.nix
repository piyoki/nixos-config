{ inputs, pkgs, system, ... }:

{
  home.packages = with pkgs; [
    microsoft-edge-dev
    inputs.chaotic.packages.${system}.firefox_nightly
    # qutebrowser
    (inputs.pilots.packages.${system}.qutebrowser_nightly.overrideAttrs {
      enableWideVine = true;
      enableVulkan = true;
    })
  ];
}
