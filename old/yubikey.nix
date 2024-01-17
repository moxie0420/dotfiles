{ pkgs, config, ...}:
{
	services = {
		udev.packages = [ pkgs.yubikey-personalization ];
		pcscd.enable = true;
	};
	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
	};
	environment.shellInit = ''
    	gpg-connect-agent /bye
    	export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  	'';
}
