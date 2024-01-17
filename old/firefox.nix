{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
    	profile-sync-daemon
  	];
	programs.firefox = {
		enable = true;
		languagePacks = [
			"en-US"
			"de"
		];
		package = pkgs.firefox-devedition;
		wrapperConfig = {
			mozillaCfg = ''
				ac_add_options --enable-replace-malloc
			'';
		};
	};
}
