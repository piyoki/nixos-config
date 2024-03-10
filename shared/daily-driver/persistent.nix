{ user, lib, ... }:

let
  mode = "0700";
  genSpecialDir = directory: { inherit directory mode; };
  commonDirsPrefix = ../../shared/modules/system/tmpfs/persistent/dirs;
in
{
  imports = [
    # shared modules
    ../modules/system/tmpfs/persistent/base.nix
  ];

  # extra persistent dirs
  environment = {
    persistence."/persistent" = {
      directories = lib.mkForce (
        (import (commonDirsPrefix + "/common-system-dirs.nix")) ++
        [ ]
      );

      # files to map
      files = lib.mkForce [
        "/etc/machine-id"
        "/etc/.smbcredentials"
      ];

      # home dirs and files to map
      users.${user} = {
        directories = lib.mkForce (
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

        files = lib.mkForce [
          ".gitconfig"
          ".wakatime.cfg"
          ".wakatime.bdb"
          ".bash_history"
          ".viminfo"
        ];
      };
    };
  };
}
