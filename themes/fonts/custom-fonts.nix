{ inputs, system, ... }:

{
  # Enable fonts
  fonts = {
    packages = with inputs.nur.packages.${system}; [
      genseki-gothic
      comic-code
      comic-code-ligatures
      vt323
      zpix-pixel
      genryu
    ];
  };
}
