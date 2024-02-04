# Tips & Tricks

<!-- vim-markdown-toc GFM -->

* [Links](#links)
* [Extras](#extras)
* [Examples](#examples)
* [Updating & Upgrading](#updating--upgrading)
  * [Commands](#commands)
* [Garbage Collection](#garbage-collection)
  * [Commands](#commands-1)
* [HomeManager](#homemanager)
  * [Introduction](#introduction)
  * [Getting Started](#getting-started)
  * [Setup](#setup)
  * [Dotfiles](#dotfiles)
* [Flakes](#flakes)
  * [Introduction](#introduction-1)
  * [Getting Started](#getting-started-1)
* [Enable flakes in configuration](#enable-flakes-in-configuration)
* [Generate](#generate)
* [Inputs and Outputs](#inputs-and-outputs)
  * [Inputs](#inputs)
  * [Outputs](#outputs)
  * [Configuration](#configuration)
* [flake.nix](#flakenix)
* [Build](#build)
* [flake.nix](#flakenix-1)
* [Build](#build-1)
  * [Updating](#updating)
  * [Flakes on fresh install](#flakes-on-fresh-install)
* [Prefetch link (git and url)](#prefetch-link-git-and-url)
  * [Git](#git)
  * [URL](#url)

<!-- vim-markdown-toc -->

## Links

- [YouTube - NixOS Setup Guide - Configuration/Home-Manager/Flakes](https://www.youtube.com/watch?v=AGVXJ-TIv3Y&t=2172s)

## Extras

- [NixOS Learn](https://nixos.org/learn.html)
- [Nix Pills](https://nixos.org/guides/nix-pills)

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

## HomeManager

### Introduction

- It's like `configuration.nix`, but for the user environment.
- Plenty more options to declare packages
- A better way to manage dotfiles

### Getting Started

- [GitHub](https://github.com/nix-community/home-manager)
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
  - Store the entire system based on `git`, setting pin ref to a specific commit if wanted
- A Very useful tool to build you own configs
  - Multiple configs in one
  - People with GitHub dotfiles will feel right at home

### Getting Started

<details><summary>Flakes Wiki</summary>
</br>

<https://nixos.wiki/wiki/Flakes>

</details>

<details><summary>Setup</summary>

## Enable flakes in configuration

```nix
# configuration.nix
#+BEGIN_SRC nix
nix = {
  package = pkgs.nixFlakes;
  extraOptions = "experimental-features = nix-command flakes";
};
#+END_SRC
```

## Generate

> **Note**: The following commands will generate a flake.nix and flake.lock file

```bash
# mkdir flake location
mkdir ~/flake; cd ~/flake
nix flake init
```

```nix
# flake.nix
{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {};
}
```

## Inputs and Outputs

### Inputs

Attribute set of all the dependencies used in in the flake

```nix
# flake.nix
#+BEGIN_SRC nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
}
#+END_SRC
```

### Outputs

Functions of an argument that uses inputs for reference

- Configure what you imported
- Can be pretty much anything : packages / configurations / modules / etc ...

```nix
# flake.nix
#+BEGIN_SRC nix
{
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
  };
}
#+END_SRC
```

</details>

### Configuration

<details><summary>NixOS</summary>

## flake.nix

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux"
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem { # <- the configuration hostname is set to "nixos"
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
    };
}
```

## Build

> **Note**: `.(#)` will just build host found in the current location.

Copy config

```bash
cp -r /etc/nixos/* <flake_location>
# e.g
# cp -r /etc/nixos/* ~/flake
```

Build

```bash
sudo nixos-rebuild switch --flake .#nixos
```

> **Note**: `flake.lock` will be generated afterwards

</details>

<details><summary>Home Manager</summary>

## flake.nix

Configure inside nixosConfigurations

```nix
# flake.nix
{
  inputs = {
    ...
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      ...
      user = "kev";
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
    };
}
```

## Build

> **Note**: `.(#)` will just build the host found in the current location.

Copy config

```bash
cp -r /etc/nixos/* <flake_location>
# e.g
# cp -r /etc/nixos/* ~/flake
```

Build

```bash
sudo nixos-rebuild switch --flake .#nixos
```

> **Note**: `flake.lock` will be generated afterward

</details>

### Updating

> **Note**: This will update the `flake.lock` file. If the flake is hosted on GitHub, then every time before you rebuild the system, you need to run `git add .` to make sure flake can pick up any new local changes.

```bash
# update state lock
nix flake update # --recreate-lock-file
# rebuild and switch
sudo nixos-rebuild switch --flake .#nixos
```

### Flakes on fresh install

> **Note**: (Prerequisites) Boot into ISO

```bash
sudo su
nix-env -iA nixos.git
git clone <repo url> /mnt/<path>
nixos-install --flake .#<host>
reboot
```

Remove default configurations (Not needed anymore)

```bash
sudo rm -rf /etc/nixos/configuration.nix
```

## Prefetch link (git and url)

Reference: https://old.reddit.com/r/NixOS/comments/10ueaev/how_do_i_get_the_sha256_for_a_package_to_use_in/

### Git

```bash
nix-prefetch-git
# nix-prefetch-git --url 'https://github.com/yqlbu/dot-rofi' --rev 'refs/heads/x1-carbon'

# output:
git revision is caf2c90fdd081479692a5bf48d669d5d2d2ec0be
path is /nix/store/w69sjd6qrnvkadr4pwwhq38nw8z856q3-dot-rofi
git human-readable version is -- none --
Commit date is 2024-02-04 17:19:38 +0800
hash is 030rzigrh33gd4mxydjrj9gl7pnl1d72hj9a5344zmxvcx1y1v0c
{
  "url": "https://github.com/yqlbu/dot-rofi",
  "rev": "caf2c90fdd081479692a5bf48d669d5d2d2ec0be",
  "date": "2024-02-04T17:19:38+08:00",
  "path": "/nix/store/w69sjd6qrnvkadr4pwwhq38nw8z856q3-dot-rofi",
  "sha256": "030rzigrh33gd4mxydjrj9gl7pnl1d72hj9a5344zmxvcx1y1v0c",
  "hash": "sha256-DOzgQ2e710/IKCpJKE4L1N5DX5JZNt8raW8MmF/8GQw=",
  "fetchLFS": false,
  "fetchSubmodules": false,
  "deepClone": false,
  "leaveDotGit": false
}
```

usage

```nix
{ pkgs, ... }:

let
  repo = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "dot-hypr";
    rev = "5e71f2fd9b0992c73872d34d0bc6a8570724172f";
    sha256 = "0sa4s1gx13lcrlf85jklixgcl7k1plzy6v6xlpy49h673xxivrnl";
  };
in
{
  xdg.configFile."hypr".source = (repo + "/");
}
```

### URL

```bash
nix-prefetch-url
```
