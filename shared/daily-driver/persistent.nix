{ inputs, user, ... }:

let
  mode = "0700";
  genSpecialDir = directory: { inherit directory mode; };
  commonDirsPrefix = ../modules/system/tmpfs/persistent/dirs;
in
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    ../modules/system/tmpfs/persistent/nix-daemon.nix
  ];

  # extra persistent dirs
  environment = {
    persistence."/persistent" = {
      directories = (
        (import (commonDirsPrefix + "/common-system-dirs.nix")) ++
        [ ]
      );

      # files to map
      files = [
        "/etc/machine-id"
        "/etc/.smbcredentials"
      ];

      # home dirs and files to map
      users.${user} = {
        directories = (
          (import (commonDirsPrefix + "/common-home-dirs.nix")) ++
          (import (commonDirsPrefix + "/common-xdg-dirs.nix")) ++
          [
            (genSpecialDir "flake")
            (genSpecialDir ".gnupg")
            (genSpecialDir ".ssh")

            # custom XDG_DIRS
            "Tank"
            "Pikpak"
            "Media"
            "Workspace"

            "go"
            ".mozilla"
            ".npm"
            ".cargo"
            ".wakatime"
            ".icons"
            ".mc"
            ".gitconfigs"
          ]
        );

        files = [
          ".gitconfig"
          ".wakatime.cfg"
          ".wakatime.bdb"
          ".bash_history"
          ".viminfo"
          ".tmux.conf"
        ];
      };
    };
  };
}
