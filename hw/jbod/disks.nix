{ config, pkgs, lib, ... }:
{
    disko.devices = {
        disk = 
        let
        {
            type = "disk"; 
            content = {
                type = "gpt";
                partitions = {
                    boot = {
                        size = "500M";
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
        }
        in
        {
            { device = "/dev/sda" };
            { device = "/dev/sdb" };
            { device = "/dev/sdc" };
            { device = "/dev/sdd" };
        }
    };
}