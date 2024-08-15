# justfile
# cheatsheet: https://cheatography.com/linux-china/cheat-sheets/justfile/

# ===== Settings ===== #

# define alias
alias b := rebuild
alias e := eval

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

# update a particular flake input with fzf
upx:
  @nix flake metadata --json | nix run nixpkgs#jq '.locks.nodes.root.inputs[]' | sed 's/\"//g' | nix run nixpkgs#fzf | xargs nix flake lock --update-input

# show flake outputs
show:
  @nix flake show

# check flake
check:
  @nix flake check

# locate pkg
locate pkg:
  @nix eval nixpkgs#{{ pkg }}.outPath

# build nix pkg
build pkg:
  @nom build .#{{ pkg }}

# eval and build nixosConfiguration for currentSystem
fast-build:
  @nix run .#nix-fast-build -- --flake ".#checks.$(nix eval --raw --impure --expr builtins.currentSystem)"

# eval and build nixosConfiguration for all profiles
fast-build-all:
  @nix run .#nix-fast-build

# eval
eval host=profile:
  @nix build .#nixosConfigurations.{{ host }}.config.system.build.toplevel --print-out-paths

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
dot-clean config:
  @rm -rf ${HOME}/.config/{{ config }}

# rsync nvim configs from dot-nvim
dot-test config:
  @rsync -avz --copy-links --chmod=D2755,F744 $HOME/Workspace/personal/dot-submodules/dot-{{ config }}/ ${HOME}/.config/{{ config }}
