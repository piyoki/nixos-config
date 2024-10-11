{ inputs, system, ... }:

{
  home.file."Pictures/Avatars".source = inputs.assets.packages.${system}.wallpapers + "/share/avatars";
}
