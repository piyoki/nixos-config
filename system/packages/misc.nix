{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # misc
    brightnessctl # This program allows you read and control device brightness
    cifs-utils # Tools for managing Linux CIFS client filesystems
    dmidecode # A tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard
    libnotify # A library that sends desktop notifications to a notification daemon
    libva-utils # A collection of utilities and examples for VA-API
    cpufetch # Simplistic yet fancy CPU architecture fetching tool
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    intel-gpu-tools # Tools for development and testing of the Intel DRM driver
    glxinfo # Test utilities for OpenGL
    acpi # Show battery status and other ACPI information
  ];
}
