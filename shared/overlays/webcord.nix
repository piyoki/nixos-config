_:

# Override default launch args for webcord
# References:
# https://www.reddit.com/r/NixOS/comments/u2vw1f/how_to_override_the_version_of_a_package_that/
[
  (self: super: {
    webcord = super.webcord.overrideAttrs (oldAttrs: {
      desktopItems = [
        (self.makeDesktopItem {
          name = "webcord";
          exec = "webcord --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --enable-wayland-ime --enable-features=WebRTCPipeWireCapturer";
          icon = "webcord";
          desktopName = "WebCord";
          comment = oldAttrs.meta.description;
          categories = [ "Network" "InstantMessaging" ];
        })
      ];
    });
  })
]
