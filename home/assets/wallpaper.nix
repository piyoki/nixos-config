{ inputs, system, ... }:

{
  home.file."Pictures/Wallpapers".source = inputs.assets.packages.${system}.wallpapers + "/share/wallpapers";
}
