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

- https://wiki.archlinux.org/title/systemd/User
- https://haseebmajid.dev/posts/2023-10-08-how-to-create-systemd-services-in-nix-home-manager/
