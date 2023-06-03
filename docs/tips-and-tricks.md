# Configuration Tips

- [Updating & Upgrading](#updating-upgrading)
- [Garbage Collection](#updating-upgrading)

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

```haskell
system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
};
```

</details>

## Garbage Collection

### Commands

<details><summary>Remove undeclared packaged, dependencies and symlinks</summary>
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

```haskell
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
- Plenty more options to declare package
- Also a better way to manage dotfiles

### Getting Started

- [GitHub](https://github.com/nix-community/home-manager/)
- [Manual](https://nix-community.github.io/home-manager/index.html)
- [Appendix A](https://nix-community.github.io/home-manager/options.html)

### Setup

<details><summary>Initialize (as a user)</summary>
</br>

Add the channel

> **Warning**: Need to be run with root privileges if you want to use the NixOS Module
