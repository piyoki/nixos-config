{ ... }:

{
  # Enable fonts
  fonts = {
    packages = with pkgs; [
      source-han-sans
      source-han-serif
    ];
  };
}

