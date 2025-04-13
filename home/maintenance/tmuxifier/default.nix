{ inputs, ... }:

{
  home.file.".local/tmuxifier".source = inputs.home-estate + "/tmuxifier";
}
