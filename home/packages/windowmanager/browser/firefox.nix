{ pkgs, ... }:

# References:
# https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265/23
let
  lock = { Status = "locked"; };
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true; }) { };
    policies = {
      /* ---- PREFERENCES ---- */
      # Set preferences shared by all profiles.
      Preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = { Value = true; } // lock;
        "browser.contentblocking.category" = { Value = "strict"; } // lock;
        "extensions.pocket.enabled" = { Value = true; } // lock;
        "extensions.screenshots.disabled" = { Value = false; } // lock;
        # Ref: https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration
        "gfx.webrender.all" = { Value = true; } // lock;
      };
      /* ---- EXTENSIONS ---- */
      # To add any addons, manually install it then find the UUID in about:debugging#/runtime/this-firefox.
      ExtensionSettings = with builtins;
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        in
        listToAttrs [
          (extension "toby-for-tabs" "toby-ext@gettoby.com")
          (extension "tree-style-tab" "treestyletab@piro.sakura.ne.jp")
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
          (extension "bookmarkhub" "{9c37f9a3-ea04-4a2b-9fcc-c7a814c14311}")
          (extension "link-redirect-trace" "{5327e982-d0be-4b85-b661-dba2ef210ab8}")
          (extension "octotree" "jid1-Om7eJGwA1U8Akg@jetpack")
          (extension "picture-in-picture" "{31a4c81b-add0-4ce4-b6e4-b54dcb0f4d1b}")
          (extension "pockettube" "danabok16@gmail.com")
          (extension "rsshub-radar" "i@diygod.me")
          (extension "tampermonkey" "firefox@tampermonkey.net")
          (extension "webrtc-control" "jid0-oFxt2GoakYukFl7Yp42Kq@jetpack")
          (extension "print-friendly-pdf" "jid0-YQz0l1jthOIz179ehuitYAOdBEs@jetpack")
          (extension "language-tool" "731ac4a9-3751-488d-877b-d793c1d33cae")
          (extension "simplify-jobs" "sabre@simplify.jobs")
        ];
    };
  };
}
