{ ... }:
{
  fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/c0de85f9-7225-44d9-a30f-4d039b73968d";
			fsType = "ext4";
			options = [ "defaults" "noatime" "commit=60" ];
  	};
  	"/boot" = {
			device = "/dev/disk/by-uuid/28BE-0B4A";
			fsType = "vfat";
  	};
  };
  swapDevices = [ { 
  	device = "/dev/disk/by-uuid/6b5312e0-7a50-4272-a68c-6c3116414587"; 
  } ];
}
