# References:
# https://nixos.wiki/wiki/AMD_GPU

# OpenGL related:
# https://discourse.nixos.org/t/what-exactly-does-hardware-opengl-extrapackages-influence/36384/2

{ inputs, config, lib, pkgs, modulesPath, system, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    # Use the systemd-boot EFI boot loader.
    kernelPackages = inputs.chaotic-kernel.packages.${system}.linuxPackages_cachyos-lto;
    # kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ext4" "btrfs" "xfs" "fat" "vfat" "cifs" "nfs" ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules = [ "nvme" "thunderbolt" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "lz4" ];
      kernelModules = [ "amdgpu" "i2c_dev" "coretemp" ];
      luks.devices."root" = {
        device = "/dev/disk/by-uuid/a1a6982e-78b9-49ae-9563-a60c7f3ec282";
        # the keyfile(or device partition) that should be used as the decryption key for the encrypted device.
        # if not specified, you will be prompted for a passphrase instead.
        #keyFile = "/root-part.key";

        # whether to allow TRIM requests to the underlying device.
        # it's less secure, but faster.
        allowDiscards = true;
        # Whether to bypass dm-crypt’s internal read and write workqueues.
        # Enabling this should improve performance on SSDs;
        # https://wiki.archlinux.org/index.php/Dm-crypt/Specialties#Disable_workqueue_for_increased_solid_state_drive_(SSD)_performance
        bypassWorkqueues = true;
      };
    };

    kernelModules = [ "kvm-amd" ];
    kernelParams = [ ];
    extraModulePackages = [ ];
    extraModprobeConfig = ''
    '';

    tmp = {
      # Clear /tmp on boot to get a stateless /tmp directory.
      cleanOnBoot = true;
      # Size of tmpfs in percentage.
      tmpfsSize = "20%"; # default "50%"
    };
  };

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/e42e5d91-8863-4773-bbe4-10aa8e8185b6";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/e42e5d91-8863-4773-bbe4-10aa8e8185b6";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/e42e5d91-8863-4773-bbe4-10aa8e8185b6";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."/snapshots" =
    {
      device = "/dev/disk/by-uuid/e42e5d91-8863-4773-bbe4-10aa8e8185b6";
      fsType = "btrfs";
      options = [ "subvol=@snapshots" ];
    };

  fileSystems."/persistent" =
    {
      device = "/dev/disk/by-uuid/e42e5d91-8863-4773-bbe4-10aa8e8185b6";
      fsType = "btrfs";
      options = [ "subvol=@persistent" ];
    };

  fileSystems."/tmp" =
    {
      device = "/dev/disk/by-uuid/e42e5d91-8863-4773-bbe4-10aa8e8185b6";
      fsType = "btrfs";
      options = [ "subvol=@tmp" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/FDF8-EDDF";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Network
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;

  # GPU (Accelerate Video Playback)
  # ref: https://nixos.wiki/wiki/Accelerated_Video_Playback
  # nixpkgs.config.packageOverrides = pkgs: {
  #   vaapiIntel = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  # };

  hardware = {
    # linux-firmware
    enableAllFirmware = true;

    # GPU (OpenGL)
    graphics = {
      enable = false; # use mesa-git instead
      extraPackages = with pkgs; [
        inputs.chaotic-kernel.packages.${system}.mesa_git.opencl # OpenCL support for Mesa
        amdvlk # AMD Open Source Driver For Vulkan
        rocmPackages.clr.icd # AMD Common Language Runtime for hipamd, opencl, and rocclr
        vaapiVdpau # VDPAU driver for the VAAPI library
        libvdpau-va-gl # VDPAU driver with OpenGL/VAAPI backend
        libdrm # Direct Rendering Manager library and headers
      ];
    };

    # CPU
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  # OpenGL (mesa-git)
  chaotic.mesa-git.enable = true;

  # Extra hardware packages
  environment.systemPackages = with pkgs; [
    amdgpu_top # Tool to display AMDGPU usage
    dmidecode # A tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard
    libnotify # A library that sends desktop notifications to a notification daemon
    libva-utils # A collection of utilities and examples for VA-API
    cpufetch # Simplistic yet fancy CPU architecture fetching tool
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    glxinfo # Test utilities for OpenGL
    acpi # Show battery status and other ACPI information
  ];


  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  nixpkgs.hostPlatform = lib.mkDefault system;
}