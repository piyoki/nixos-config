{ pkgs-stable }:

{
  permittedInsecurePackages = [
    "ventoy-1.1.05"
  ];


  environment.systemPackages = with pkgs-stable; [
    # productivity
    ventoy # bootable usb solution
  ];
}
