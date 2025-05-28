_:

# ttyd - Share your terminal over the web
# References:
# https://github.com/tsl0922/ttyd

{
  services = {
    # Enable ttyd service
    ttyd = {
      enable = true;
      writeable = true;
      port = 7681;
      terminalType = "xterm-256color";
      maxClients = 2;
      clientOptions = {
        # https://xtermjs.org/docs/api/terminal/interfaces/iterminaloptions/
        fontSize = "16";
        fontFamily = "Maple Mono NF";
      };
    };
  };
}
