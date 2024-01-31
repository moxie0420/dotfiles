{ pkgs, ... }:
{
	services = {
		udev.packages = [ pkgs.yubikey-personalization ];
		pcscd.enable = true;
	};
	programs.gnupg.agent = {
		enable = false;
		enableSSHSupport = true;
	};
	environment.shellInit = ''
    	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  	'';
}
