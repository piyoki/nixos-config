{ inputs, pkgs, system, ... }:

{
  home.packages = with pkgs; [
    inputs.chaotic.packages.${system}.telegram-desktop_git
    cinny-desktop # Yet another matrix client for desktop
    webcord # A Discord and SpaceBar electron-based client implemented without Discord API
    # (webcord.overrideAttrs (oldAttrs: {
    #   desktopItems = [
    #     (makeDesktopItem {
    #       name = "webcord";
    #       exec = "webcord --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto --enable-wayland-ime --enable-features=WebRTCPipeWireCapturer";
    #       icon = "webcord";
    #       desktopName = "WebCord";
    #       comment = oldAttrs.meta.description;
    #       categories = [ "Network" "InstantMessaging" ];
    #     })
    #   ];
    # }))
  ];
}
