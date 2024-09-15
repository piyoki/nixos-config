{ sharedLib, ... }:

# Avahi - Service Discovery for Linux using mDNS/DNS-SD -- compatible with Bonjour

# References:
# https://github.com/avahi/avahi
# https://search.nixos.org/options?channel=unstable&show=services.avahi.enable&from=0&size=30&sort=relevance&type=packages&query=avahi
# https://wiki.archlinux.org/title/PipeWire#Streaming_audio_to_an_AirPlay_receiver
# https://taoa.io/posts/Setting-up-ipad-screen-mirroring-on-nixos
# https://www.reddit.com/r/linuxquestions/comments/183rsic/apple_airplay_on_linux/
# https://docs.pipewire.org/page_module_raop_sink.html

# Maintenance:
# sudo systemctl restart avahi-daemon
# systemctl --user restart pipewire pipewire-pulse wireplumber


{
  imports = (map sharedLib.relativeToRoot [
    "system/networking/firewall/avahi-daemon.nix"
  ]);

  services = {
    # Enable Avahi service
    avahi = {
      enable = true;
      # Reflect incoming mDNS requests to all allowed network interfaces.
      reflector = true;
      wideArea = true;
      # Whether to enable the mDNS NSS (Name Service Switch) plug-in for IPv4. Enabling it allows applications to resolve names in the .local domain by transparently querying the Avahi daemon.
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };

    # Enable raop-discovery for (airplay) configuration on Pipewire server
    # /etc/pipewire/pipewire.conf.d
    pipewire.extraConfig.pipewire."raop-sink" = {
      "context.modules" = [
        { name = "libpipewire-module-raop-discover"; args = { }; }
      ];
    };
  };
}
