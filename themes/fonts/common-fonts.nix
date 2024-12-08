{ pkgs, ... }:

{
  # Enable fonts
  fonts = {
    packages = with pkgs; [
      cantarell-fonts
      maple-mono
      maple-mono-NF
      noto-fonts
      noto-fonts-extra
      noto-fonts-emoji
      noto-fonts-emoji-blob-bin
      source-code-pro

      # Nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix
      # [deprecated syntax]
      # (nerdfonts.override {
      #   fonts = [
      #     # symbols icon only
      #     "NerdFontsSymbolsOnly"
      #     # Characters
      #     "FiraCode"
      #     "JetBrainsMono"
      #   ];
      # })
      # [new syntax]
      # Refresh cache: fc-cache -r
      # Symbols icon only
      nerd-fonts.symbols-only
      # Characters
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];
  };
}
