{
  "server.toml" = {
    keyFile = /run/user/1000/secrets/atuin/server-config;
    destDir = "/etc/atuin/config";
    user = "nobody";
    group = "nogroup";
    permissions = "0755";
  };
  "env" = {
    keyFile = /run/user/1000/secrets/atuin/env;
    destDir = "/etc/atuin";
  };
}
