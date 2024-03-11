path:

{
  home = {
    file = {
      # gnupg
      ".gnupg/scdaemon.conf".text = builtins.readFile ./conf/scdaemon.conf;
      ".gnupg/gpg.conf".text = builtins.readFile path;
    };
  };
}
