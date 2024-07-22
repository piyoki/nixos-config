{ pkgs, ... }:

{
  i18n.inputMethod = {
    # type = "fcitx5";
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
      fcitx5-material-color
    ];
  };
}
