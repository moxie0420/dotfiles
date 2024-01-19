{ config, pkgs, lib, ... }:
with lib;
{
	users.mutableUsers = true;
	networking.firewall = {
		enable = true;
		allowedTCPPorts = [];
		allowedUDPPorts = [];
	};
	systemd.coredump.enable = false;

	nix.settings.allowed-users = mkDefault [ "@users" ];

	environment = {
		memoryAllocator.provider = mkDefault "libc";
	};
	security = {
		forcePageTableIsolation = true;
		lockKernelModules = false;
		unprivilegedUsernsClone = mkDefault config.virtualisation.containers.enable;
		apparmor = {
			enable = mkDefault true;
			killUnconfinedConfinables = mkDefault false;
			packages = with pkgs; [
				firejail
			];
		};
		sudo.enable = false;
		sudo-rs = {
			enable = true;
			execWheelOnly = true;
		};
		pam = {
			u2f.enable = true;
			services = {
				login.u2fAuth = true;
				sudo.u2fAuth = true;
				swaylock.u2fAuth = true;
			};
		};
		tpm2 = {
			enable = true;
			pkcs11.enable = true;
			tctiEnvironment.enable = true;
		};
	};
	boot = {
		kernel.sysctl = {
			# Hide kptrs even for processes with CAP_SYSLOG
			"kernel.kptr_restrict" = mkOverride 500 2;
			# Disable bpf() JIT (to eliminate spray attacks)
			"net.core.bpf_jit_enable" = mkDefault false;
			# Disable ftrace debugging
			"kernel.ftrace_enabled" = mkDefault false;
			# Enable strict reverse path filtering (that is, do not attempt to route
  			# packets that "obviously" do not belong to the iface's network; dropped
 			# packets are logged as martians).
			"net.ipv4.conf.all.log_martians" = mkDefault true;
			"net.ipv4.conf.all.rp_filter" = mkDefault "1";
			"net.ipv4.conf.default.log_martians" = mkDefault true;
			"net.ipv4.conf.default.rp_filter" = mkDefault "1";

			# Ignore broadcast ICMP (mitigate SMURF)
			"net.ipv4.icmp_echo_ignore_broadcasts" = mkDefault true;

			# Ignore incoming ICMP redirects (note: default is needed to ensure that the
			# setting is applied to interfaces added after the sysctls are set)
			"net.ipv4.conf.all.accept_redirects" = mkDefault false;
			"net.ipv4.conf.all.secure_redirects" = mkDefault false;
			"net.ipv4.conf.default.accept_redirects" = mkDefault false;
			"net.ipv4.conf.default.secure_redirects" = mkDefault false;
			"net.ipv6.conf.all.accept_redirects" = mkDefault false;
			"net.ipv6.conf.default.accept_redirects" = mkDefault false;

			# Ignore outgoing ICMP redirects (this is ipv4 only)
			"net.ipv4.conf.all.send_redirects" = mkDefault false;
			"net.ipv4.conf.default.send_redirects" = mkDefault false;
		};
		kernelParams = [
			# Enable page allocator randomization
    		"page_alloc.shuffle=1"
		];
		blacklistedKernelModules = [
			# Obscure network protocols
    		"ax25"
    		"netrom"
    		"rose"
			# Old or rare or insufficiently audited filesystems
    		"adfs"
		    "affs"
		    "bfs"
		    "befs"
		    "cramfs"
		    "efs"
		    "erofs"
		    "exofs"
		    "freevxfs"
		    "f2fs"
		    "hfs"
		    "hpfs"
		    "jfs"
		    "minix"
		    "nilfs2"
		    "ntfs"
		    "omfs"
		    "qnx4"
		    "qnx6"
		    "sysv"
		    "ufs"
		];
	};
	programs.firejail = {
		enable = true;
		wrappedBinaries = {
			firefox = {
          		executable = "${pkgs.firefox-devedition}/bin/firefox-devedition";
          		profile = "${pkgs.firejail}/etc/firejail/firefox.profile";
      		};
		};
	};
}
