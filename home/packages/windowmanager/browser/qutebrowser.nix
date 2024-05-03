{ inputs, system, ... }:

{
  home.packages = [
    (inputs.pilots.packages.${system}.qutebrowser_nightly.override {
      enableWideVine = true;
      enableVulkan = true;
    })
  ];
}
