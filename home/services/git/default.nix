_:

# References:
# https://docs.github.com/en/authentication/troubleshooting-ssh/using-ssh-over-the-https-port
# https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-your-personal-account/managing-multiple-accounts
# https://blog.gitguardian.com/8-easy-steps-to-set-up-multiple-git-accounts/

# Contributing to multiple accounts using SSH and GIT_SSH_COMMAND
# GIT_SSH_COMMAND='ssh -i ~/.ssh/<private-key> -o IdentitiesOnly=yes' git clone git@github.com:<username>/<repo>.git
{
  home.file.".gitconfig".source = ./gitconfig;
}
