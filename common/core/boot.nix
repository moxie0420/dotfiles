{
  pkgs,
  lib,
  ...
}: {
  services.udev.extraRules = ''
    KERNEL=="ntsync", MODE="0644"

    # SATA Active Link Power Management
    ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", \
      ATTR{link_power_management_policy}=="*", \
      ATTR{link_power_management_policy}="max_performance"

    # HDD
    ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", \
      ATTR{queue/scheduler}="bfq"

    # SSD
    ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", \
      ATTR{queue/scheduler}="mq-deadline"

    # NVMe SSD
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", \
      ATTR{queue/scheduler}="none"
  '';

  boot = {
    bootspec.enable = true;

    extraModprobeConfig = ''
      options nvidia NVreg_UsePageAttributeTable=1 \
        NVreg_InitializeSystemMemoryAllocations=0 \
        NVreg_RegistryDwords=RMIntrLockingMode=1
    '';

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4"];
      verbose = false;
    };

    # use latest zen kernel
    kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;

    consoleLogLevel = 0;
    kernel.sysctl = {
      "vm.swappiness" = 100;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_bytes" = 268435456;
      "vm.page-cluster" = 1;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_writeback_centisecs" = 1500;
      "kernel.nmi_watchdog" = 0;
      "net.ipv4.tcp_ecn" = 1;
      "net.core.netdev_max_backlog" = 4096;
      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "fs.file-max" = 2097152;
    };
    kernelModules = ["sg"];
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    loader = {
      # systemd-boot on UEFI
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        consoleMode = "max";
        editor = false;
        enable = true;
      };
      timeout = 0;
    };

    plymouth.enable = true;

    tmp.cleanOnBoot = true;
  };
}
