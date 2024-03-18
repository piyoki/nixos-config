{ pkgs, ... }:

{
  programs = {
    # disable ssh-agent
    ssh.startAgent = false;

    # gnupg-agent
    gnupg = {
      agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses;
        enableSSHSupport = true;
        # /etc/gnupg/gpg-agent.conf
        settings = {
          enable-ssh-support = "";
          ttyname = "$GPG_TTY";
          default-cache-ttl = 60;
          max-cache-ttl = 120;
          allow-loopback-pinentry = "";
        };
      };
    };
  };

  # reset gpg-agent
  environment.shellInit = ''
    /run/current-system/sw/bin/gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';
}
