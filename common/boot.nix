{
  pkgs,
  lib,
  ...
}: {
  boot = {
    consoleLogLevel = 3;

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4" "btrfs" "ntfs"];
      verbose = false;
    };

    kernelPackages = lib.mkDefault pkgs.linuxPackages_xanmod_latest;
    kernel.sysctl = {
      "vm.vfs_cache_pressure" = 50;
      "vm.page-cluster" = 1;
      "vm.max_map_count" = 2147483642;
      "net.ipv4.tcp_ecn" = 1;
      "net.core.netdev_max_backlog" = 4096;
      "net.ipv4.tcp_slow_start_after_idle" = 0;
      "net.ipv4.tcp_fin_timeout" = 5;
      "fs.file-max" = 2097152;
      "fs.inotify.max_user_watches" = 10000000;
    };

    kernel.sysfs = {
      kernel.mm.transparent_hugepage = {
        enabled = "always";
        defrag = "defer";
        shmem_enabled = "within_size";
      };

      devices.system.cpu = {
        "cpu[0-9]*" = {
          scaling_governor = "performance";
          energy_performance_preference = "performance";
        };
      };
    };

    kernelModules = ["sg" "ntsync"];
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
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

    plymouth = {
      enable = true;
      theme = lib.mkDefault "bgrt";
    };
    tmp.cleanOnBoot = true;
  };

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
      ATTR{queue/scheduler}="mq-deadline"

    # NVMe SSD
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/rotational}=="0", \
      ATTR{queue/scheduler}="none"
  '';
}
