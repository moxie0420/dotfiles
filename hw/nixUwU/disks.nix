{ ... }:
{
	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/c0de85f9-7225-44d9-a30f-4d039b73968d";
			fsType = "ext4";
			options = [ "defaults" "noatime" "commit=60" ];
  		};
  		"/boot" = {
			device = "/dev/disk/by-uuid/CEBC-2F92";
			fsType = "vfat";
  		};
		"/media/ryan-gosling" = {
			device = "/dev/disk/by-uuid/4d89cb96-1b0c-4293-ba28-61994dec3095";
			fsType = "ext4";
			options = [ "defaults" "noatime" ];
		};
	};
	swapDevices = [{ 
  		device = "/dev/disk/by-uuid/c9947b18-c60d-4b5f-adce-0d336f7e7f9f"; 
  	}];
}
