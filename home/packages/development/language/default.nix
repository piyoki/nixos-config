{ sharedLib, ... }:

{
  imports = (sharedLib.scanPaths ./.);
}