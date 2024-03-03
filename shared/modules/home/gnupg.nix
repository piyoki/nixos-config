path:

{
  home = {
    file = {
      # gnupg
      ".gnupg/gpg.conf".text = builtins.readFile path;
    };
  };
}
