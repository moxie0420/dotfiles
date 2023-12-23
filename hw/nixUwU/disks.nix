{ config, ... }:
{
    fileSystems = {
  		"/" = {
	    	device = "/dev/disk/by-uuid/c0de85f9-7225-44d9-a30f-4d039b73968d";
		    fsType = "ext4";
  	    };

  	    "/boot" = {
		    device = "/dev/disk/by-uuid/28BE-0B4A";
		    fsType = "vfat";
  	    };
  
  	    "/media/sda1" = {
   			device = "/dev/disk/by-uuid/1b92550a-2ecb-4215-865c-f6febf7dc20a";
		    options = [ "nofail" ];
	    }; 

	    "/media/sdb1" = {
		    device = "/dev/disk/by-uuid/f7f70c5e-d126-4e23-b19f-e9c6818028dc";
		    options = [ "nofail" ];
	    };

	    "/media/sdc1" = {
   			device = "/dev/disk/by-uuid/90254f4a-e9da-435a-9346-dac585d5793d";
    		options = [ "nofail" ];
	    };

   	 	"/media/sdf1" = {
    		device = "/dev/disk/by-uuid/3ff9f900-a2b8-47fd-9daa-a0ee2dd9aecf";
	    	options = [ "nofail" ];
	    };
    };
    swapDevices = [ { 
   		device = "/dev/disk/by-uuid/6b5312e0-7a50-4272-a68c-6c3116414587"; 
    } ];
}