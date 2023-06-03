##
##  | | _______   __           HIKARI AI
##  | |/ / _ \ \ / /           https://hikariai.net
##  |   <  __/\ V /            https://link.hikariai.net
##  |_|\_\___| \_/             https://github.com/yqlbu
##
## My fish shell config. Nothing fancy, but I like it

### PATH ###
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.npm-global/bin
fish_add_path /usr/bin
fish_add_path /usr/local/bin

### Link Sources ###
source $HOME/.config/fish/themes/cool-beans-nix.fish
source $HOME/.config/fish/functions/bangbang.fish
source $HOME/.config/fish/functions/gnupg.fish

### General Settings ###
set fish_greeting # Turns off the intro message when pulling up fish shell
set EDITOR "nvim" # Sets the $EDITOR to vim

export CLICOLOR=1
export LS_COLORS=(vivid generate nord)

### Fish Alias ###
abbr unset "set --erase"

### Shortcuts ###
abbr ..  "cd .."
abbr ... "cd ../../"
abbr home "cd ~"
abbr vim "nvim"
abbr lg "lazygit"
abbr top "btop"
abbr weather "curl wttr.in/"
abbr lf "lfrun"
# programs and system
abbr ls "ls -ltrh"
abbr du "du -d 1 -h"
abbr kill "killall"
abbr rm "trash -v"
# tmux
abbr t "tmux"
# kubernetes related
abbr k "kubectl"
abbr kz "kubectl kustomize"
# git related
abbr g  "git"
abbr gs "git status"
abbr gc "git checkout"
abbr gp "git pull"
abbr gf "git fetch origin --prune"
abbr gl "git log --all --decorate --oneline --graph"
abbr gcc "git fetch -p && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D"
abbr gcb "git checkout -b"
# tmux
abbr t "tmux"
# neofetch
abbr logo "neofetch"
# package manager related
abbr nb "sudo nixos-rebuild switch --flake $HOME/Workspace/nixos-config#nixos --verbose"
abbr up "nix flake update --commit-lock-file && sudo nixos-rebuild switch --flake $HOME/Workspace/nixos-config#nixos --verbose"
# kubernetes related
abbr k "kubectl"
# program
alias vlc "org.videolan.VLC"

### Device Control ###
# pb
alias pb="curl -F 'c=@-' https://fars.ee/"

### Dev ENV ###

# fzf key-remaps
fzf_configure_bindings --git_status --history=\ch --variables=\cv --directory=\cx --git_log=\cg

# lf history work-dir
bind \co 'set old_tty (stty -g); stty sane; lfcd; stty $old_tty; commandline -f repaint'

# zoxide
zoxide init fish | source
