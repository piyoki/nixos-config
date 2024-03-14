# justfile
# cheatsheet: https://cheatography.com/linux-china/cheat-sheets/justfile/

# define alias
alias b := rebuild
alias upi := update-input

# set options
set positional-arguments := true
set dotenv-load := true

# assign default value to vars
profile := "$PROFILE"

# default recipe to display help information
default:
  @just --list

# rebuild nixos
rebuild host=profile:
  @sudo nixos-rebuild switch --upgrade --flake .#{{ host }}

# remote deploy with colmena
deploy host:
  @colmena apply --verbose --on {{ host }} --show-trace

# remote deploy servers with @tags with colmena
deploy-with-tags tags:
  @colmena apply --verbose --on @{{ tags }} --show-trace

# update all flake inputs
update:
  @nix flake update

# show flake outputs
show:
  @nix flake show

# check flake
check:
  @nix flake check

# view flake.lock
view:
  @nix-melt

# update a particular flake input
update-input input:
  @nix flake lock --update-input {{ input }}

# nix-prefetch-url
prefetch-url url:
  @nix-prefetch-url --type sha256 '{{ url }}' | xargs nix hash to-sri --type sha256

# nix-prefetch-git
prefetch-git repo rev:
  @nix-prefetch-git --url 'git@github.com:{{ repo }}' --rev '{{ rev }}' --fetch-submodules

# activate nix-repl
repl:
  nix repl -f flake:nixpkgs

# remove all generations older than 7 days
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 3d

# garbage collect all unused nix store entries
gc:
  @sudo nix store gc --debug
  @sudo nix-collect-garbage --delete-old

# apply fix from linters
lint:
  @statix fix --ignore 'templates/' .
  @deadnix --edit --exclude 'templates/' .

# count total number of nix-related files
count:
  @rg '' --glob "!.git" --glob "!home-estate" --glob "!secrets" --files-with-matches | wc -l

# stage all files
add:
  @git add .

# git pull
pull:
  @git pull --rebase
