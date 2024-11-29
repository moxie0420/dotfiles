# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{lib, ...}: {
  imports = [
    ./disks.nix
    ./hardware.nix
    ./network.nix
    ./specialisations.nix
  ];

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "sdhci_pci"
      "cryptd"
      "xhci_hcd"
    ];
    kernelModules = [
      "kvm_amd"
      "amdgpu"
      "nvme"
      "pwm-lpss-platform"
    ];
    kernelParams = [
      "resume_offset=474218496"
      "acpi_backlight=native"
    ];
  };

  system.stateVersion = "23.11";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
