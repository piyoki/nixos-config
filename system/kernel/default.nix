{ pkgs, lib, ... }:

let
  kernel = pkgs.linuxPackages_cachyos.kernel;
in
{
  system.modulesTree = [ (lib.getOutput "modules" kernel) ];
}
