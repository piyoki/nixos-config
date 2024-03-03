{ user, ... }:

{
  # home-manager basic settings
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    inherit (import ../vars.nix) stateVersion;
  };

  programs.home-manager.enable = true;
}
