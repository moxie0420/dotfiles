{ pkgs, ... }:
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
		package = pkgs.firefox-devedition-bin;
	};
}
