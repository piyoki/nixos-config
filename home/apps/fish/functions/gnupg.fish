# Ensure that GPG Agent is used as the SSH agent
set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -x GPG_TTY (tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
