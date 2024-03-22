_:

# References:
# https://nixos.wiki/wiki/Qutebrowser
(_self: super: {
  qutebrowser = super.qutebrowser.override { enableWideVine = true; enableVulkan = true; };
})
