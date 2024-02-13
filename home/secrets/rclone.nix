{ inputs, config, ... }:

{
  sops.secrets = {
    "rclone/pikpak" = {
      sopsFile = "${inputs.secrets}/rclone.enc.yaml";
      mode = "0600";
      path = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
    };
  };
}
