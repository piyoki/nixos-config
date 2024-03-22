# Overlays

<!-- vim-markdown-toc GFM -->

* [References](#references)
* [Pacakge-level overrides](#pacakge-level-overrides)
* [System-level overlays](#system-level-overlays)

<!-- vim-markdown-toc -->

## References

- https://nixos-and-flakes.thiscute.world/nixpkgs/overriding
- https://nixos-and-flakes.thiscute.world/nixpkgs/overlays
- https://www.reddit.com/r/NixOS/comments/u2vw1f/how_to_override_the_version_of_a_package_that/

## Pacakge-level overrides

```nix
{ inputs, pkgs, system, ... }:

{
  home.packages = with pkgs; [
    # A Discord and SpaceBar electron-based client implemented without Discord API
    (webcord.overrideAttrs (oldAttrs: {
      desktopItems = [
        (makeDesktopItem {
          name = "webcord";
          exec = "webcord --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --enable-wayland-ime --enable-features=WebRTCPipeWireCapturer";
          icon = "webcord";
          desktopName = "WebCord";
          comment = oldAttrs.meta.description;
          categories = [ "Network" "InstantMessaging" ];
        })
      ];
    }))
  ];
}
```

## System-level overlays

```nix
_:

{
  nixpkgs.overlays = [
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
  })];
}
```
