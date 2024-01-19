{ config, pkgs, lib, ... }:
{
    # partitions
    disko.devices = {
        disk = 
        let
            type = "disk"; 
            content = {
                type = "gpt";
                partitions = {
                    boot = {
                        size = "1000M";
                        type = "EF00";
                        content = {
                            type = "mdraid";
                            name = "boot";
                        };
                    };
                    primary = {
                        size = "100%";
                        content = {
                            type = "lvm_pv";
                            vg = "pool";
                        };
                    };
                };
            };
        in
        {
            disk1 = { device = "/dev/sda"; };
            disk2 = { device = "/dev/sdb"; };
            disk3 = { device = "/dev/sdc"; };
            disk4 = { device = "/dev/sdd"; };
            
        } ++ {
            mdadm = {
                boot = {
                    type = "mdadm";
                    level = 1;
                    metadata = "1.0";
                    content = {
                        type = "filesystem";
                        format = "vfat";
                        mountpoint = "/boot";
                    };
                };
            };
            lvm_vg = {
                pool = {
                    type = "lvm_vg";
                    lvs = {
                        root = {
                            size = "500G";
                            lvm_type = "raid5";
                            content = {
                                type = "filesystem";
                                format = "ext4";
                                mountpoint = "/";
                                mountOptions = [
                                    "defaults"
                                ];
                            };
                        };
                        swap = {
                            size = "500G";
                            content = {
                                type = "swap";
                                resumeDevice = true;
                            };
                        };
                        home = {
                            size = "1000G";
                            lvm_type = "raid0";
                            content = {
                                type = "filesystem";
                                format = "ext4";
                                mountpoint = "/home";
                            };
                        };
                    };
                };
            };
        };
    };


}