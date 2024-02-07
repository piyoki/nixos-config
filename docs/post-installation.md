# Post Installation

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Set flags for application](#set-flags-for-application)

<!-- vim-markdown-toc -->

## Set flags for application

Ref: https://old.reddit.com/r/NixOS/comments/13bo4fw/how_to_set_flags_for_application/

Copy the .desktop file to $HOME/.local/share/applications

```sh
ls -ltrh /etc/profiles/per-user/kev/share/applications/ | grep <application>
# $HOME/.local/share/<application>.desktop
```
