{ inputs, system, ... }:

{
  # Public wallpapers from nur-assets
  home.file."Pictures/Wallpapers/Public".source = inputs.assets.packages.${system}.wallpapers + "/share/wallpapers";
  # Private wallpapers from home-estate
  home.file."Pictures/Wallpapers/Private/Chroma".source = inputs.home-estate.packages.${system}.chroma_wallpapers + "/share/chroma_wallpapers";
}
