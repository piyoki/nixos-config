{ inputs, config, ... }:

{
  # git
  sops.secrets = builtins.mapAttrs (_name: value: value // {
    sopsFile = "${inputs.secrets}/nix.gitconfig.enc.yaml";
    mode = "0600";
  }) {
    "gitconfig/general".path = "${config.home.homeDirectory}/.gitconfig";
    "gitconfig/profile/personal".path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.personal";
    "gitconfig/profile/work".path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.work";
    "gitconfig/profile/extras".path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.extras";
  };
}
