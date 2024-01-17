{ config, pkgs, ... }:

{
	sound = {
		mediaKeys.enable = true;
	};
	services.pipewire = {
		enable = true;
		alsa = {
			enable = true;
			support32Bit = true;
		};
		pulse.enable = true;
	};
}
