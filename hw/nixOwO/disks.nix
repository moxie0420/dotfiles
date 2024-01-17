{ config, lib, pkgs, ...}:

{
	fileSystems = {
		"/" = {
			device = "/dev/mapper/nixroot";
			fsType = "ext4";
			label = "nixy";
			options = [
				"defaults"
				"noatime"
				"data=journal"
				"journal_async_commit"
			];
		};
		"/boot" = {
			device = "/dev/disk/by-uuid/5F30-508A";
			fsType = "vfat";
			label = "the boring stuff";
		};
	};
	boot.initrd.luks.devices."nixroot" = {
		device = "/dev/nvme0n1p3";
		allowDiscards = true;
	};

	swapDevices = [ {
		device = "/swapfile"; size=64000;
	}];
}
