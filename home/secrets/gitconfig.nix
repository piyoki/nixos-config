{ config, ... }:

{
  sops.secrets = {
    # git
    "gitconfig/general" = {
      sopsFile = ../../secrets/gitconfig.enc.yaml;
      mode = "0600";
      path = "${config.home.homeDirectory}/.gitconfig";
    };
    "gitconfig/profile/personal" = {
      sopsFile = ../../secrets/gitconfig.enc.yaml;
      mode = "0600";
      path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.personal";
    };
    "gitconfig/profile/work" = {
      sopsFile = ../../secrets/gitconfig.enc.yaml;
      mode = "0600";
      path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.work";
    };
    "gitconfig/profile/extras" = {
      sopsFile = ../../secrets/gitconfig.enc.yaml;
      mode = "0600";
      path = "${config.home.homeDirectory}/.gitconfigs/.gitconfig.extras";
    };
  };
}
