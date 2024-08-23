# Reference:
# https://nixos.wiki/wiki/Flatpak

# Usage:
# flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# flatpak update
# flatpak search bustle
# flatpak install flathub org.freedesktop.Bustle
# flatpak run org.freedesktop.Bustle
{
  services.flatpak.enable = true;
}
