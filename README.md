<h1 align="center">❄️ Nix Flake</h1>
<p align="center">
    <em>Declare Nix System as Code</em>
</p>
<p align="center">
  <img src="https://custom-icon-badges.herokuapp.com/github/license/piyoki/nixos-config?style=flat&logo=law&colorA=24273A&color=blue" alt="License"/>
  <img src="https://custom-icon-badges.herokuapp.com/badge/Hyprland-latest-000.svg?style=flat&logo=hypr&colorA=24273A&colorB=6CC5D9&logoColor=CAD3F5"/>
  <img src="https://img.shields.io/badge/NixOS-unstable-informational.svg?style=flat&logo=nixos&logoColor=CAD3F5&colorA=24273A&colorB=8AADF4">
  <img src="https://img.shields.io/badge/Nix Flake-checked-informational.svg?style=flat&logo=nixos&colorA=24273A&colorB=9173ff&logoColor=CAD3F5">
  <img src="https://custom-icon-badges.herokuapp.com/github/last-commit/piyoki/nixos-config?style=flat&logo=history&colorA=24273A&colorB=C4EEF2" alt="lastcommit"/>
</p>

![image](https://github.com/user-attachments/assets/9f4079e3-6bdf-454b-a946-443e4d7aa97f)
![image](https://github.com/user-attachments/assets/b1584f71-9ad2-4eb5-b694-07a29ef47849)

> [!NOTE]
> This repo contains the declarative configuration of a few NixOS systems, with ~100% config nixfied.

## Introduction

As the date of writing (March 2024), I've committed myself switching to NixOS on my daily-drivers and a few servers. This repository reflects my current multi-profile NixOS configuration with Flake. I'd like to actively learn more about Nix, specially NixOS with Flake. In my view, NixOS is a revolutionary invention in the Linux world, as it offers a new paradigm of system configuration and package management. It is not only reliable and secure, but also fun and rewarding to use.

## Upstream inputs

- [pilots](https://github.com/NixOS-Pilots) to get bleeding-edge softwares from NixOS-Pilots.
- [chaotic](https://github.com/chaotic-cx/nyx) to get bleeding-edge softwares from nyx.
- [home-manager](https://github.com/nix-community/home-manager) configurations as flake module.
- [sops-nix](https://github.com/Mic92/sops-nix) to decrypt in-flight secrets from remote.
- [nixpkgs-wayland](https://github.com/nix-community/nixpkgs-wayland) to fetch up-to-date wayland packages for daily usage.
- [hyprland](https://github.com/hyprwm/Hyprland) to fetch up-to-date Hyprland packages for daily usage.
- [pyprland](https://github.com/hyprland-community/pyprland) to fetch up-to-date Hyprland plugins for daily usage.
- [rust-nightly-overlay](https://github.com/nix-community/fenix) to fetch nightly rust packages for daily usage.
- [neovim-nightly-overlay](https://github.com/nix-community/neovim-nightly-overlay) to fetch nightly neovim package for daily usage.
- [impemenance](https://github.com/nix-community/impermanence) to create tmpfs root stateless OS.
- [pre-commit-hooks](https://github.com/cachix/pre-commit-hooks.nix) to integrate pre-commit-hooks with flake.
- [microvm](https://github.com/astro/microvm.nix) to spin up microvm locally in seconds.
- [nix-fast-build](https://github.com/Mic92/nix-fast-build) to speed up evaluation and building process.
- [auto-cpufreq](https://github.com/AdnanHodzic/auto-cpufreq) to optimize power management and efficiency.

## References

### Wikis

- [How to Learn Nix](https://ianthehenry.com/posts/how-to-learn-nix)
- [Nix Pills](https://nixos.org/guides/nix-pills/index.html)
- [Nix Flakes](https://nixos.wiki/wiki/Flakes)
- [Nix Language](https://nixos.org/manual/nix/stable/language/)
- [NixOS & Flakes Book](https://nixos-and-flakes.thiscute.world/)
- [Nix Dev](https://nix.dev/)
- [MyNixOS](https://mynixos.com/)
- [Noogle](https://noogle.dev/)
- [NixOS CN](https://nixos-cn.org/)
- [Awesome Nix](https://github.com/nix-community/awesome-nix)
- [Nixpkgs Pull Request Tracker](https://nixpk.gs/pr-tracker.html)

### Configs from open-source community

- [NixOS Config (@librephoenix/nixos-config)](https://github.com/librephoenix/nixos-config)
- [NixOS Config (@ryan4yin/nix-config)](https://github.com/ryan4yin/nix-config)

## Community

- [NixOS-CN-telegram](https://t.me/nixos_zhcn)
- [NixOS-CN-Matrix](https://matrix.to/#/%23zh-cn:nixos.org)
- [NixOS-Redit](https://www.reddit.com/r/NixOS/)
