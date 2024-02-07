# Post Installation

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Set flags for application](#set-flags-for-application)

<!-- vim-markdown-toc -->

## Set flags for application

Ref: https://discourse.nixos.org/t/where-are-desktop-files-located/17391

Copy the .desktop file to $HOME/.local/share/applications

```sh
ls -ltrh /etc/profiles/per-user/kev/share/applications/ | grep <application>
# $HOME/.local/share/<application>.desktop
```
