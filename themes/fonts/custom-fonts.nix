{ inputs, pkgs, ... }:

{
  # Enable fonts
  fonts = {
    packages = with pkgs; [
      inputs.nur.packages.${system}.genseki-gothic
      inputs.nur.packages.${system}.comic-code
    ];
  };
}
