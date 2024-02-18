# Hooks

<!-- vim-markdown-toc GFM -->

* [Usage](#usage)
* [References](#references)

<!-- vim-markdown-toc -->

## Usage

list units

```bash
systemctl --user list-units
```

manually run a service once for testing purposes

```bash
systemctl start --user <name>.service
```

inspect journal logs

```bash
journalctl --user -xeu relaunch-waybars.service | less
```

## References

- https://wiki.archlinux.org/title/systemd
- https://nixos.wiki/wiki/Systemd_Hardening
- https://haseebmajid.dev/posts/2023-10-08-how-to-create-systemd-services-in-nix-home-manager/
- https://discourse.nixos.org/t/nixos-22-11-systemd-user-services-dont-start-automatically-but-global-ones-do/24809
- https://discourse.nixos.org/t/disable-a-systemd-service-while-having-it-in-nixoss-conf/12732/4
