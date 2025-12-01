{ pkgs, ... }:

# References:
# https://nixos.wiki/wiki/Virt-manager
# https://www.surlyjake.com/blog/2020/10/09/ubuntu-cloud-images-in-libvirt-and-virt-manager/
# https://www.reddit.com/r/NixOS/comments/qd7rg6/difficulties_with_libvirt_qemu_hooks_ovmf_secboot/

# Win11 VM:
# https://www.youtube.com/watch?v=Zei8i9CpAn0
# https://www.reddit.com/r/VFIO/comments/q253sr/windows_11_system_doesnt_meet_minimum_requirements/
# https://discourse.nixos.org/t/windows-11-vm-on-nixos/30631
# https://superuser.com/a/1762882

# Win11 Supplements Download:
# https://www.microsoft.com/en-us/software-download/windows11
# https://github.com/virtio-win/virtio-win-pkg-scripts
# https://www.spice-space.org/download.html

{
  # enable virtmanager
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        # The 'virtualisation.libvirtd.qemu.ovmf' submodule has been removed. All OVMF images distributed with QEMU are now available by default.
        # ovmf = {
        #   packages = [ pkgs.OVMFFull.fd ];
        #   enable = true;
        # };
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  # trust the default bridge interface
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  environment = {
    systemPackages = with pkgs; [ virtio-win ];
    sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
  };
}
