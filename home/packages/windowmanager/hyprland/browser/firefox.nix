{ inputs, system, ... }:

# References:
# https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265/23
let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  programs.firefox = {
    enable = true;
    package = inputs.chaotic.packages.${system}.firefox_nightly;
    policies = {
      /* ---- PREFERENCES ---- */
      # Set preferences shared by all profiles.
      Preferences = {
        "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
        "extensions.pocket.enabled" = lock-false;
        "extensions.screenshots.disabled" = lock-true;
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
        ];
    };
  };
}
