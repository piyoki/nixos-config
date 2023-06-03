# Tips & Tricks

- [Links](#links)
- [Examples](#examples)
- [Extras](#extras)
- [Updating & Upgrading](#updating-upgrading)
- [Garbage Collection](#updating-upgrading)
- [Home Manager](#home-mannager)
- [Flakes](#flakes)

## Links

- [YouTube - NixOS Setup Guide - Configuration/Home-Manager/Flakes](https://www.youtube.com/watch?v=AGVXJ-TIv3Y&t=2172s)

## Extras

- [NixOS Learn](https://nixos.org/learn.html/)
- [Nix Pills](https://nixos.org/guides/nix-pills/)

## Examples

- [List of reference configurations](https://nixos.wiki/wiki/Configuration_Collection)

## Updating & Upgrading

### Commands

<details><summary>Update channel</summary>
</br>

```bash
nix-channel --update
```

</details>

<details><summary>Upgrade the system</summary>
</br>

```bash
sudo nixos-rebuild switch --upgrade
```

</details>

<details><summary>Configuration</summary>
</br>

```nix
system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
};
```

</details>

## Garbage Collection

### Commands

<details><summary>Remove undeclared packaged, dependencies, and symlinks</summary>
</br>

```bash
sudo nix-collect-garbage
```

</details>

<details><summary>Remove above of older generations</summary>
</br>

```bash
sudo nix-collect-garbage --delete-old
```

</details>

<details><summary>List generations</summary>
</br>

```bash
sudo nix-env --list-generations
```

</details>

<details><summary>Remove specific generations or older than ... days</summary>
</br>

```bash
sudo nix-env --delete-generations 14d
sudo nix-env --delete-generations 10 11
```

</details>

<details><summary>Optimize store</summary>
</br>

```bash
sudo nix-store --gc
```

</details>

<details><summary>All in one (*)</summary>
</br>

```bash
sudo nix-collect-garbage -d
```

</details>

<details><summary>Configuration</summary>
</br>

```nix
nix = {
  settings.auto-optimize-store = true;
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete older-than 7d";
  };
};
```

</details>

## Home-Manager

- It's like `configuration.nix`, but for the user environment.
- Plenty more options to declare packages
- A better way to manage dotfiles

### Getting Started

- [GitHub](https://github.com/nix-community/home-manager/)
- [Manual](https://nix-community.github.io/home-manager/index.html)
- [Appendix A - Configuration Options](https://nix-community.github.io/home-manager/options.html)
- [Appendix B - NixOS Module Options](https://nix-community.github.io/home-manager/nixos-options.html)

### Setup

<details><summary>Initialize (as a user)</summary>
</br>

Add the home-manager channel

> **Warning**: Need to run with root privileges if you want to use the NixOS Module

```bash
# add
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
# list
sudo nix-channel --list
# remove
sudo nix-channel --remove release-23.05.tar.gz
# update
sudo nix-channel --update
```

</details>

<details><summary>NixOS Module (Recommended)</summary>
</br>

Add to `configuration.nix`

```nix
# configuration.nix
let
  user = "kev";
in
{
  imports = [ <home-manager/nixos> ];

  users.users.${user} = {
    isNormalUser = true;
  }

  home-manager.users.${user} = { pkgs, ... }: {
    home.packages = [ pkgs.htop pkgs.httpie ];
  }
}
```

Alternatively, add to a separate `home.nix` file (Recommended)

```nix
# configuration.nix
let
  user = "kev";
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = import ./home.nix;
  };
}
```

```nix
# home.nix
{ config, pkgs, ... }:

let
  user = "kev";
in
{
  imports = [
    ./apps/app.nix # <- app-configs go here
  ];

  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    htop
    httpie
  ];
}
```

</details>

### Dotfiles

<details><summary>Copy/Symlinks</summary>
</br>

Migrate config files

```nix
#+BEGIN_SRC nix
home.file = {
  ".config/alacritty/alacritty.yml".text = ''
    {"font": {"bild": {"style":"Bold"}}}
  '';
};
#+END_SRC
```

</details>

<details><summary>Stored files (also with no link to NixOS)</summary>
</br>

```nix
#+BEGIN_SRC nix
home.file.".doom.d" = {
  source ./doom.d;
  recursive = true;
  onChange = builtins.readFile ./doom.sh; # <- run this script when there are changes made to ".doom.d"
};
home.file.".config/polybar/script/mic.sh" = { # <- copy source file to destination path
  source = ./mic.sh;
  executable = true;
}

#+END_SRC
```

</details>

## Flakes

### Introduction

- Flakes is an "upcoming feature" of the Nix package manager.
- Specify code dependencies declaratively (will be stored in `flake.lock`, e.g `home-manager`)
- Rebuilding and updating whole system made easy
- Very useful tool to build you rown config
  - Multiple configs in one
  - People with GitHub dotfiles will feel right at home

### Getting Started

### Configuration

### Updating

### Flakes on fresh install
