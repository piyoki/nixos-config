{ inputs, system, ... }:

{
  home.file."Pictures/Avatars".source = inputs.assets.packages.${system}.wallpapers + "/share/avatars";
  home.file.".face".source = inputs.assets.packages.${system}.avatars + "/share/avatars/default.jpg";
}
