path:

{
  home = {
    file = {
      # gnupg
      ".gnupg/scdaemon.conf".text = builtins.readFile ./scdaemon.conf;
      ".gnupg/gpg.conf".text = builtins.readFile path;
    };
  };
}
