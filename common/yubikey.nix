{ pkgs, ... }:
{
	services = {
		udev.packages = [ pkgs.yubikey-personalization ];
		pcscd.enable = true;
	};
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
		pinentryFlavor = "gtk";
	};
	environment.shellInit = ''
    	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  	'';
}
