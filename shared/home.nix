{ user, ... }:

{
  # home-manager basic settings
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    inherit (import ./vars) stateVersion;
  };

  programs.home-manager.enable = true;
}
