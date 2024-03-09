# justfile
# cheatsheet: https://cheatography.com/linux-china/cheat-sheets/justfile/

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

# rebuild nixos
rebuild host=profile:
  @sudo nixos-rebuild switch --upgrade --flake .#{{ host }}

deploy host:
  @colmena apply --verbose --on {{ host }}

# update all flake inputs
update:
  @sudo nix flake update

# show flake outputs
show:
  @nix flake show

# update a particular flake input
update-input input:
  @sudo nix flake lock --update-input {{ input }}

# nix-prefetch-url
prefetch-url url:
  @nix-prefetch-url --type sha256 '{{ url }}' | xargs nix hash to-sri --type sha256

# nix-prefetch-git
prefetch-git repo rev:
  @nix-prefetch-git --url 'git@github.com:{{ repo }}' --rev '{{ rev }}' --fetch-submodules

# nix-collect-garbage
gc:
  @sudo nix-collect-garbage -d

# stage all files
add:
  @git add .

# count total number of nix-related files
count:
  @rg '' --glob "!.git" --glob "!home-estate" --glob "!secrets" --files-with-matches | wc -l

# git pull
pull:
  @git pull --rebase

# apply fix from linters
lint:
  @statix fix --ignore 'templates/' .
  @deadnix --edit --exclude 'templates/' .

# check flake
check:
  @nix flake check
