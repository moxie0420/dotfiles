{
  pkgs,
  lib,
  ...
}: {
  services.scx.enable = true;

  services.udev.extraRules = ''
    KERNEL=="ntsync", MODE="0644"
    KERNEL=="rtc0", GROUP="audio"
    KERNEL=="hpet", GROUP="audio"

    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", \
        ATTRS{id/bus}=="ata", RUN+="${pkgs.hdparm}/bin/hdparm -B 254 -S 0 /dev/%k"

    DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"


    # SATA Active Link Power Management
    ACTION=="add", SUBSYSTEM=="scsi_host", KERNEL=="host*", \
      ATTR{link_power_management_policy}=="*", \
      ATTR{link_power_management_policy}="max_performance"

    # HDD
    ACTION=="add|change", KERNEL=="sd[a-z]*", ATTR{queue/rotational}=="1", \
      ATTR{queue/scheduler}="bfq"

    # SSD
    ACTION=="add|change", KERNEL=="sd[a-z]*|mmcblk[0-9]*", ATTR{queue/rotational}=="0", \
      ATTR{queue/scheduler}="adios"

    # NVMe SSD
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", \
      ATTR{queue/scheduler}="adios"
  '';

  boot = {
    extraModprobeConfig = ''
      options nvidia NVreg_UsePageAttributeTable=1 \
        NVreg_InitializeSystemMemoryAllocations=0 \
        NVreg_DynamicPowerManagement=0x02
    '';

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4" "btrfs"];
      verbose = false;
    };

    kernelPackages = lib.mkDefault pkgs.linuxPackages_cachyos;

    consoleLogLevel = 3;
    kernel.sysctl = {
      "vm.swappiness" = 150;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_bytes" = 268435456;
      "vm.page-cluster" = 0;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_writeback_centisecs" = 1500;
      "vm.max_map_count" = 2147483642;
      "kernel.nmi_watchdog" = 0;
      "kernel.unprivileged_userns_clone" = 1;
      "kernel.printk" = "3 3 3 3";
      "kernel.kptr_restrict" = 2;
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;
      "kernel.split_lock_mitigate" = 0;
      "net.ipv4.tcp_ecn" = 1;
      "net.core.netdev_max_backlog" = 4096;
      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "net.ipv4.tcp_fin_timeout" = 5;
      "fs.file-max" = 2097152;
    };
    kernelModules = ["sg" "ntsync"];
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    blacklistedKernelModules = ["iTCO_wdt" "sp5100_tco"];

    loader = {
      # systemd-boot on UEFI
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        consoleMode = "max";
        editor = false;
        enable = true;
      };
      timeout = 2;
    };
    tmp.cleanOnBoot = true;
  };
}
