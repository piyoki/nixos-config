{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fprintd # D-Bus daemon that offers libfprint functionality over the D-Bus interprocess communication bus
  ];
}


