{
  "server.toml" = {
    keyFile = /run/secrets/atuin/server-config;
    destDir = "/etc/atuin/config";
    user = "nobody";
    group = "nogroup";
    permissions = "0755";
  };
  "env" = {
    keyFile = /run/secrets/atuin/env;
    destDir = "/etc/atuin";
  };
}
