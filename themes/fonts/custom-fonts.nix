{ inputs, pkgs, ... }:

{
  # Enable fonts
  fonts = {
    packages = with pkgs; [
      inputs.nur.packages.${system}.genseki-gothic
      inputs.nur.packages.${system}.comic-code
      inputs.nur.packages.${system}.comic-code-ligatures
      inputs.nur.packages.${system}.vt323
      inputs.nur.packages.${system}.dank-mono
    ];
  };
}
