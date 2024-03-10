{ inputs, user, lib, ... }:

with lib;
let
  cfg = config.modules.persistent;
  mode = "0700";
  commonDirsPrefix = ./dirs;
  genSpecialDir = directory: { inherit directory mode; };
in
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
    ./nix-daemon.nix
  ];

  options.modules.persistent = {
    enable = mkEnableOption "Load persistent settings";
    hostType = mkOption {
      type = types.str;
      default = "workstation";
      description = "Host type; [ workstation server ]";
    };
  };

  config = mkIf cfg.enable (
    mkMerge [
      # common attrs
      { environment.persistence."/persistent".hideMounts = true; };

      # profile specific attrs
      (mkIf (cfg.profile == "workstation") {
        environment.persistence."/persistent" = {
          # system dirs and files to map
          directories = import (commonDirsPrefix + "/common-system-dirs.nix");

          files = [
            "/etc/machine-id"
            "/etc/.smbcredentials"
          ];

          # home dirs and files to map
          users.${user} = {
            directories = (import (commonDirsPrefix + "/common-home-dirs.nix")) ++
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

                # excluded, conflicts with sops-nix
                # ".gitconfigs"
                # ".mc"
              ];

            files = [
              ".wakatime.cfg"
              ".wakatime.bdb"
              ".bash_history"
              ".viminfo"
              ".tmux.conf"

              # excluded, conflicts with sops-nix
              # ".gitconfig"
            ];
          };
        };
      })
    ]
  );
}
