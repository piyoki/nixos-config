_:

{
  # $HOME/.config/
  xdg.configFile."path/file".text = builtins.readFile ./file;
  xdg.configFile."path/dir".source = ./dir;

  # $HOME
  home.file."path/dir".source = ./dir;
}
