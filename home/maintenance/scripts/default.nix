{ inputs, ... }:

{
  home.file.".local/scripts".source = inputs.home-estate + "/scripts";
}
