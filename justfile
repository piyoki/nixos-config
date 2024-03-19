# justfile
# cheatsheet: https://cheatography.com/linux-china/cheat-sheets/justfile/

# ===== Settings ===== #

# define alias
alias b := rebuild

# set options
set positional-arguments := true
set dotenv-load := true

# assign default value to vars
profile := "$PROFILE"

# default recipe to display help information
default:
  @just --list

# ===== Nix ===== #

# rebuild nixos
rebuild host=profile:
  @sudo nixos-rebuild switch --upgrade --flake .#{{ host }}

# build nixos (debug mode)
rebuild-debug host=profile:
  @nom build .#nixosConfigurations.{{ host }}.config.system.build.toplevel --show-trace --verbose

# update all flake inputs
up:
  @nix flake update

# update a particular flake input
upp input:
  @nix flake lock --update-input {{ input }}

# show flake outputs
show:
  @nix flake show

# check flake
check:
  @nix flake check

# build nix pkg
build pkg:
  @nom build .#{{ pkg }}

# run nix pkg
run pkg:
  @nix run .#{{ pkg }}

# view flake.lock
view:
  @nix-melt

# nix-prefetch-url
prefetch-url url:
  @nix-prefetch-url --type sha256 '{{ url }}' | xargs nix hash to-sri --type sha256

# nix-prefetch-git
prefetch-git repo rev:
  @nix-prefetch-git --url 'git@github.com:{{ repo }}' --rev '{{ rev }}' --fetch-submodules

# activate nix-repl
repl:
  @nix repl -f flake:nixpkgs

# remove all generations older than 7 days
clean:
  @sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 3d

# garbage collect all unused nix store entries
gc:
  @sudo nix store gc --debug
  @sudo nix-collect-garbage --delete-old

# apply fix from linters
lint:
  @statix fix --ignore 'templates/' .
  @deadnix --edit --exclude 'templates/' .

# ===== Remote deploy ===== #

# remote deploy with colmena
deploy host:
  @colmena apply --verbose --on {{ host }} --show-trace

# remote deploy servers with @tags with colmena
deploy-with-tags tags:
  @colmena apply --verbose --on @{{ tags }} --show-trace

# ===== Misc ===== #

# count total number of nix-related files
count:
  @rg '' --glob "!.git" --glob "!home-estate" --glob "!secrets" --files-with-matches | wc -l

# ===== Git ===== #

# stage all files
add:
  @git add .

# git pull
pull:
  @git pull --rebase

# ===== Tests ===== #

# clean nvim configs
nvim-clean:
  @rm -rf ${HOME}.config/nvim

# rsync nvim configs from dot-nvim
nvim-test: nvim-clean
  @rsync -avz --copy-links --chmod=D2755,F744 $HOME/Workspace/personal/dot-submodules/dot-nvim/ ${HOME}/.config/nvim
