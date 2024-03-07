{ inputs, system, ... }:

{
  home.file."Pictures/Wallpapers".source = inputs.nur.packages.${system}.wallpapers + "/share/wallpapers";
}
