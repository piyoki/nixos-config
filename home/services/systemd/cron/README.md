# Cron (Systemd Timer)

<!-- vim-markdown-toc GFM -->

* [Usage](#usage)
* [References](#references)

<!-- vim-markdown-toc -->

## Usage

list active timers and their current state

```bash
systemctl list-timers --all
```

manually run a service once for testing purposes

```bash
systemctl start --user <name>.service
```

inspect timer status

```bash
systemctl status --user <name>.timer
```

inspect journal logs

```bash
journalctl --user -xeu relaunch-waybars.service | less
```

## References

- https://wiki.archlinux.org/title/systemd/User
- https://wiki.archlinux.org/title/Systemd/Timers
- https://man.archlinux.org/man/systemd.timer.5
- https://haseebmajid.dev/posts/2023-10-08-how-to-create-systemd-services-in-nix-home-manager/
- https://gist.github.com/oprypin/0f0c3479ab53e00988b52919e5d7c144/
