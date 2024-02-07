{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # inputs.helix.packages."${pkgs.system}".helix
  ];
}

