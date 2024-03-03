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

  dotfiles = {
    rofi.profile = "laptop";
    waybar.profile = "laptop";
    hypr.profile = "laptop";
    dunst.profile = "laptop";
  };
}
