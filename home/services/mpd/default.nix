{ config, ... }:

# References:
# https://nixos.wiki/wiki/MPD
# https://nixos.wiki/wiki/MPD
# https://wiki.archlinux.org/index.php/Mpd
let
  homeDir = config.home.homeDirectory;
  dataDir = "${homeDir}/.local/share/mpd";
in
{
  services.mpd = {
    enable = true;
    network.listenAddress = "any"; # allow non-localhost connections
    musicDirectory = "${homeDir}/Music";
    playlistDirectory = "${dataDir}/playlists";
    dbFile = "${dataDir}/database";
    extraConfig = ''
      log_file "syslog"
      state_file "${dataDir}/state"
      sticker_file "${dataDir}/sticker.sql"
      auto_update "yes"
      restore_paused "yes"
      audio_output {
        type "pipewire"
        name "PipeWire Output"
      }
    '';
  };
}
