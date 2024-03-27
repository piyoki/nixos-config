{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (chromium.override {
      commandLineArgs = [
        # Force GPU accleration
        "--ignore-gpu-blocklist"
        "--enable-zero-copy"

        # Force to run on Wayland
        "--ozone-platform-hint=auto"
        "--ozone-platform=wayland"
        "--enable-wayland-ime"

        # Enable additional features
        "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoDecoder,Vulkan,WebRTCPipeWireCapturer,WaylandWindowDecorations"
      ];
    })
  ];
}
