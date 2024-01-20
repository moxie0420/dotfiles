{ config, pkgs, lib, ... }:
{
    boot = {
        hardwareScan = true;
        loader = {
			efi.canTouchEfiVariables = true;
			timeout = 0;
			systemd-boot = {
                enable = true;
				editor = false;
				configurationLimit = 5;
				memtest86.enable = false;
			};
		};
    };
    initrd = {
		compressor = "zstd";
		verbose = false;
		systemd = {
			enable = true;
			dbus.enable = true;
		};
	};
}