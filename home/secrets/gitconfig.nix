{ inputs, config, ... }:

{
  sops.secrets = {
    # git
    "gitconfig/general" = {
      sopsFile = "${inputs.secrets}/gitconfig.enc.yaml";
      mode = "0600";
      path = "${config.home.homeDirectory}/.gitconfig";
    };
    "gitconfig/profile/personal" = {
      sopsFile = "${inputs.secrets}/gitconfig.enc.yaml";
      mode = "0600";
      path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.personal";
    };
    "gitconfig/profile/work" = {
      sopsFile = "${inputs.secrets}/gitconfig.enc.yaml";
      mode = "0600";
      path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.work";
    };
    "gitconfig/profile/extras" = {
      sopsFile = "${inputs.secrets}/gitconfig.enc.yaml";
      mode = "0600";
      path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.extras";
    };
  };
}
