_:

{
  imports = [
    ./modules/secrets.nix
  ];

  home = {
    file = {
      # gnupg
      ".gnupg/gpg.conf".text = builtins.readFile ./conf/gpg.conf;
    };
  };
}
