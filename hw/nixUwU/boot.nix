{
  config,
  pkgs,
  ...
}: {
  boot = {
    hardwareScan = true;
    loader = {
      timeout = 0;
      systemd-boot = {
        enable = true;
        editor = true;
        configurationLimit = 5;
        memtest86.enable = true;
      };
      grub = {
        enable = false;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
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
    extraModulePackages = with pkgs.linuxKernel.packages; [
      #callPackage ./ch340.nix {};
      linux_testing.v4l2loopback
    ];
    blacklistedKernelModules = [
      "nouveau"
    ];
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      "nvidia-drm.fbdev=1"
      "v4l2loopback.exclusive_caps=1"
      "nvidia.NVreg_EnablePCIeGen3=1"
      "nvidia.NVreg_UsePageAttributeTable=1"
      "video=DP-1:3840x2160@144D"
      #"nouveau.config=NvGspRm=1"
      "kernel.sysrq=1"
    ];
    kernelPackages = pkgs.linuxPackages_testing;
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
      "kernel.sysrq" = 1;
    };
    extraModprobeConfig = ''
      options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3"
    '';
    supportedFilesystems = ["ntfs"];
  };
  environment.systemPackages = [pkgs.scx];
}
