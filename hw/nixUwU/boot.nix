{
  config,
  pkgs,
  ...
}: {
  systemd.tmpfiles.settings = {
    "hibernate file" = {
      "/sys/power/image_size" = {
        w.argument = "160000000000";
      };
    };
  };
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    hardwareScan = true;
    loader = {
      timeout = 0;
      systemd-boot = {
        enable = false;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod" "vfio-pci"];
      kernelModules = ["kvm-intel"];
      systemd.enable = true;
    };
    kernelModules = ["coretemp" "nct6775"];
    extraModulePackages = with config.boot.kernelPackages; [
      #callPackage ./ch340.nix {};
      v4l2loopback
    ];
    blacklistedKernelModules = [
      "nouveau"
    ];
    kernelParams = [
      "nvidia-drm.fbdev=1"
      "v4l2loopback.exclusive_caps=1"
      "nvidia.NVreg_EnablePCIeGen3=1"
      "nvidia.NVreg_UsePageAttributeTable=1"
    ];
    kernelPackages = pkgs.linuxPackages_zen;
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
      "fs.inotify.max_user_watches" = 10000000;
      "kernel.sysrq" = 1;
    };
    extraModprobeConfig = ''
      options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3"
    '';
    supportedFilesystems = ["ntfs"];
    enableContainers = true;
  };
}
