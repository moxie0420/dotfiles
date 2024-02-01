{ ...}:

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
			device = "/dev/disk/by-uuid/A048-7A0C";
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
