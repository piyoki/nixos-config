# References:
# https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Carbon_(Gen_12)
# https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Carbon_(Gen_11)
# https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Carbon_(Gen_10)
# https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Carbon_(Gen_9)
# https://wiki.archlinux.org/title/Lenovo_ThinkPad_X1_Carbon
# https://nixos.wiki/wiki/Intel_Graphics

# Hardware (Realtek Audio) issues troubleshooting:
# Notes: this issue happens since Linux Kernel 6.7.x
# https://discourse.nixos.org/t/sound-not-working/12585/15
# https://discourse.nixos.org/t/realtek-audio-sound-card-not-recognized-by-pipewire/36637/3
# https://discourse.nixos.org/t/intel-tiger-lake-pro-audio-no-audio/40592/2

# Workaround solution:
# https://bbs.archlinux.org/viewtopic.php?id=292393

# Useful commands:
# View options of a specific kernel module
# sudo modinfo i915 | egrep -i "guc|huc|dmc"

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
      availableKernelModules = [ "xe" "i915" "xhci_pci" "thunderbolt" "nvme" "usbhid" "usb_storage" "sd_mod" "lz4" ];
      kernelModules = [ "xe" "i915" "i2c_dev" "coretemp" ];
      luks.devices."root" = {
        device = "/dev/disk/by-uuid/79869bdd-49a1-44d5-b57c-0ca9fa89c4c9";
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

    kernelModules = [ "kvm-intel" ];
    kernelParams = [ ];
    extraModulePackages = [ ];
    extraModprobeConfig = ''
      # blacklist legacy realtek codec (since Kernel 6.7.x)
      blacklist snd_hda_codec_realtek

      # Load intel dsp driver for audio
      options snd-intel-dspcfg dsp_driver=1

      # Apply intel integrated graphics params
      options i915 force_probe=!7d55
      options xe enable_guc=1 enable_fbc=1 enable_psr=1 force_probe=7d55
    '';

    tmp = {
      # Clear /tmp on boot to get a stateless /tmp directory.
      cleanOnBoot = true;
      # Size of tmpfs in percentage.
      tmpfsSize = "20%"; # default "50%"
    };
  };

  fileSystems = {
    "/" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ "relatime" "size=25%" "mode=755" ];
    };

    "/nix" =
      {
        device = "/dev/disk/by-uuid/54b6c0e4-9b42-4549-be1d-49d43aff9263";
        fsType = "btrfs";
        options = [ "noatime" "space_cache=v2" "compress=zstd" "ssd" "discard=async" "subvol=@nix" ];
      };

    "/persistent" =
      {
        device = "/dev/disk/by-uuid/54b6c0e4-9b42-4549-be1d-49d43aff9263";
        fsType = "btrfs";
        options = [ "noatime" "space_cache=v2" "compress-force=zstd" "ssd" "discard=async" "subvol=@persistent" ];
        # impermanence's data is required for booting
        neededForBoot = true;
      };

    "/snapshots" =
      {
        device = "/dev/disk/by-uuid/54b6c0e4-9b42-4549-be1d-49d43aff9263";
        fsType = "btrfs";
        options = [ "noatime" "space_cache=v2" "compress=zstd" "ssd" "discard=async" "subvol=@snapshots" ];
      };

    "/boot" =
      {
        device = "/dev/disk/by-uuid/28E0-4664";
        fsType = "vfat";
      };
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
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  hardware = {
    # linux-firmware
    enableAllFirmware = true;

    # GPU (OpenGL)
    graphics = {
      enable = true;
      # if you also want 32-bit support (e.g for Steam)
      extraPackages = with pkgs; [
        intel-compute-runtime # Intel Graphics Compute Runtime for OpenCL. Replaces Beignet for Gen8 (Broadwell) and beyond
        intel-media-driver # Intel Media Driver for VAAPI; # LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # VAAPI user mode driver for Intel Gen Graphics family; # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        # vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau # VDPAU driver for the VAAPI library
        libvdpau-va-gl # VDPAU driver with OpenGL/VAAPI backend
      ];
    };

    # CPU
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  # OpenGL (mesa-git)
  chaotic.mesa-git.enable = false;

  # High-DPI console
  console.font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";

  nixpkgs.hostPlatform = lib.mkDefault system;
}
