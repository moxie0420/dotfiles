# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./disks.nix
    ./hardware.nix
    ./network.nix
  ];

  environment.variables.FLAKE = "/etc/nixos";

  services = {
    fstrim.enable = true;
  };

  boot = {
    blacklistedKernelModules = [
      "nouveau"
      "nvidia"
      "nvidia_drm"
      "nvidia_modeset"
    ];
    initrd = {
      compressor = "zstd";
      verbose = false;
      availableKernelModules = [
        "xhci_pci"
        "usbhid"
        "sdhci_pci"
        "cryptd"
        "aesni_intel"
        "xhci_hcd"
      ];
      systemd = {
        enable = true;
        dbus.enable = true;
      };
    };
    kernelModules = [
      "kvm_amd"
      "amdgpu"
      "nvme"
    ];
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "rootflags=noatime"
      "resume_offset=474218496"
      "acpi_backlight=native"
    ];
    plymouth.enable = true;
    resumeDevice = "/dev/mapper/nixroot";
  };

  services = {
    udev.extraRules = ''
      ACTION=="remove",\
          			ENV{ID_BUS}=="usb",\
      	ENV{ID_MODEL_ID}=="0407",\
      	ENV{ID_VENDOR_ID}=="1050",\
      	ENV{ID_VENDOR}=="Yubico",\
      	RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"

      ACTION=="add",\
          			ENV{ID_BUS}=="usb",\
      	ENV{ID_MODEL_ID}=="0407",\
      	ENV{ID_VENDOR_ID}=="1050",\
      	ENV{ID_VENDOR}=="Yubico",\
      	RUN+="${pkgs.systemd}/bin/loginctl unlock-sessions"
    '';
  };
  system.stateVersion = "23.11";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
