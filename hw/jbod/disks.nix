{ ... }:
{
    # partitions
    disko.devices = {
        disk = 
        let
        a = {
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
        };
        in
        {
            inherit a;
            disk1 = { device = "/dev/sda"; } ++ a;
            disk2 = { device = "/dev/sdb"; } ++ a;
            disk3 = { device = "/dev/sdc"; } ++ a;
            disk4 = { device = "/dev/sdd"; } ++ a;
            
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