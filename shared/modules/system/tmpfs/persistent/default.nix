{ config, inputs, user, lib, ... }:

with lib;
let
  cfg = config.modules.persistent;
  mode = "0700";
  genDir = directory: { inherit directory mode; };
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
      { environment.persistence."/persistent".hideMounts = true; }

      # workstation specific attrs
      (mkIf (cfg.hostType == "workstation") {
        environment.persistence."/persistent" = {
          # system dirs and files to map
          directories = import ./dirs/common-system-dirs.nix;

          files = [ "/etc/machine-id " ] ++
            (import ./files/workstation-system-specific.nix);

          # home dirs and files to map
          users.${user} = {
            directories = (import ./dirs/common-home-dirs.nix) ++
              (import ./dirs/common-misc-dirs.nix) ++
              (import ./dirs/common-xdg-dirs.nix) ++
              (import ./dirs/extra-xdg-dirs.nix) ++
              [
                (genDir "flake")
                (genDir ".gnupg")
                (genDir ".ssh")

                # excluded, conflicts with sops-nix
                # ".gitconfigs
                # ".mc"
              ];

            files = (import ./files/workstation-home-specific.nix) ++
              [
                ".bash_history"
                ".viminfo"
                ".tmux.conf"

                # excluded, conflicts with sops-nix
                # ".gitconfig
              ];
          };
        };
      })

      # server specific attrs
      (mkIf (cfg.hostType == "server") {
        environment.persistence."/persistent" = {
          # system dirs and files to map
          directories = import ./dirs/common-system-dirs.nix;

          files = [ "/etc/machine-id" ];

          # home dirs and files to map
          users.${user} = {
            directories = (import ./dirs/common-home-dirs.nix) ++
              [
                (genDir "flake")
                (genDir ".gnupg")
                (genDir ".ssh")
              ];

            files = [
              # excluded, conflicts with sops-nix
              # ".gitconfig
            ];
          };
        };
      })
    ]
  );
}
