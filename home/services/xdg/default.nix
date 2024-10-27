{ config, ... }:

{
  xdg = {
    enable = true;
    configFile."mimeapps.list".force = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    # manage $XDG_CONFIG_HOME/mimeapps.list
    # xdg search all desktop entries from $XDG_DATA_DIRS, check it by command:
    #  echo $XDG_DATA_DIRS
    # the system-level desktop entries can be list by command:
    #   ls -l /run/current-system/sw/share/applications/
    # the user-level desktop entries can be list by command:
    #  ls /etc/profiles/per-user/${user}/share/applications/
    mimeApps = {
      enable = true;
      # let `xdg-open` to open the url with the correct application.
      defaultApplications =
        let
          browser = [ "firefox.desktop" ];
          editor = [ "nvim.desktop" ];
          document = [ "org.kde.okular.deskto" ];
        in
        {
          "application/json" = browser;
          "application/pdf" = document;

          "text/html" = browser;
          "text/xml" = browser;
          "text/plain" = editor;
          "application/xml" = browser;
          "application/xhtml+xml" = browser;
          "application/xhtml_xml" = browser;
          "application/rdf+xml" = browser;
          "application/rss+xml" = browser;
          "application/x-extension-htm" = browser;
          "application/x-extension-html" = browser;
          "application/x-extension-shtml" = browser;
          "application/x-extension-xht" = browser;
          "application/x-extension-xhtml" = browser;
          "application/x-wine-extension-ini" = editor;

          # define default applications for some url schemes.
          "x-scheme-handler/about" = browser; # open `about:` url with `browser`
          "x-scheme-handler/ftp" = browser; # open `ftp:` url with `browser`
          "x-scheme-handler/http" = browser;
          "x-scheme-handler/https" = browser;
          # https://github.com/microsoft/vscode/issues/146408
          "x-scheme-handler/vscode" = [ "code-url-handler.desktop" ]; # open `vscode://` url with `code-url-handler.desktop`
          "x-scheme-handler/vscode-insiders" = [ "code-insiders-url-handler.desktop" ]; # open `vscode-insiders://` url with `code-insiders-url-handler.desktop`
          # all other unknown schemes will be opened by this default application.
          "x-scheme-handler/unknown" = browser;

          "x-scheme-handler/discord" = [ "discord.desktop" ];
          "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop " ];

          "audio/*" = [ "mpv.desktop" ];
          "video/*" = [ "mpv.dekstop" ];
          "image/*" = [ "imv.desktop" ];
          "image/gif" = [ "imv.desktop" ];
          "image/jpeg" = [ "imv.desktop" ];
          "image/png" = [ "imv.desktop" ];
          "image/webp" = [ "imv.desktop" ];
        };

      associations.removed = {
        # ......
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      # extra dirs
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        XDG_WALLPAPER_DIR = "${config.xdg.userDirs.pictures}/Wallpapers";
        XDG_AVATAR_DIR = "${config.xdg.userDirs.pictures}/Avatars";
        XDG_MEDIA_DIR = "${config.home.homeDirectory}/Media";
        XDG_TANK_DIR = "${config.home.homeDirectory}/Tank";
        XDG_SHARED_DIR = "${config.home.homeDirectory}/Shared";
        XDG_EXTERNAL_DIR = "${config.home.homeDirectory}/External";
        XDG_DOWNLOADS_DIR = "${config.home.homeDirectory}/Downloads";
        XDG_PICTURES_DIR = "${config.home.homeDirectory}/Pictures";
        XDG_PHOTOS_DIR = "${config.home.homeDirectory}/Photos";
        XDG_PIKPAK_DIR = "${config.home.homeDirectory}/Pikpak";
        XDG_WORKSPACE_DIR = "${config.home.homeDirectory}/Workspace";
        XDG_WORKSPACE_GIT_PERSONAL_DIR = "${config.home.homeDirectory}/Workspace/personal";
        XDG_WORKSPACE_GIT_WORK_DIR = "${config.home.homeDirectory}/Workspace/work";
        XDG_WORKSPACE_GIT_EXTRAS_DIR = "${config.home.homeDirectory}/Workspace/extras";
        XDG_WORKSPACE_GIT_DOT_SUBMODULES_DIR = "${config.home.homeDirectory}/Workspace/personal/dot-submodules";
      };
    };
  };
}
