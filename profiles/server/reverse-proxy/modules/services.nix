{ sharedLib, ... }:

{
  imports = map sharedLib.relativeToRoot [
    "system/services/caddy"
  ];
}
