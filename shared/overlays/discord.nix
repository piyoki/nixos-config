_:

# Override default launch args for discord
# References:
# https://www.reddit.com/r/NixOS/comments/u2vw1f/how_to_override_the_version_of_a_package_that/
# https://nixos-and-flakes.thiscute.world/nixpkgs/overlays
(self: super: {
  discord = super.webcord.overrideAttrs (oldAttrs: {
    desktopItems = [
      (self.makeDesktopItem {
        name = "discord";
        exec = "discord --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --enable-wayland-ime --enable-features=WebRTCPipeWireCapturer";
        icon = "discord";
        desktopName = "discord";
        comment = oldAttrs.meta.description;
        categories = [ "Network" "InstantMessaging" ];
      })
    ];
  });
})
