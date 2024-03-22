_:

# References:
# https://nixos.wiki/wiki/Qutebrowser
(oldAttrs: {
  qutebrowser = oldAttrs.qutebrowser.override { enableWideVine = true; };
})
