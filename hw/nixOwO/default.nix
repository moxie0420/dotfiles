# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, lib, ... }:

{
	imports = [
		./boot.nix
		../../common
		../../common/harden.nix
		../../common/hardware/laptop.nix
		../../common/desktop/applications/wiki.nix
		./disks.nix
		./hardware.nix
		./network.nix
    ];

  	# Set your time zone.
  	time.timeZone = "America/Chicago";

	# Select internationalisation properties.
  	i18n.defaultLocale = "en_US.UTF-8";
  	console = {
		enable = false;
		earlySetup = false;
    	keyMap = lib.mkDefault "us";
    	useXkbConfig = true; # use xkbOptions in tty.
	};

	documentation = {
		enable = true;
		man = {
			enable = true;
			generateCaches = true;
		};
		dev.enable = true;
	};

	services = {
		printing.enable = true;
		gvfs.enable = true;
		tumbler.enable = true;
		thermald.enable = true;
		udisks2 = {
			enable = true;
			mountOnMedia = true;
		};
		fstrim.enable = true;
	};

	environment = {
		systemPackages = with pkgs; [
			sbctl
			babelfish
		];
	};

	programs = {
		fish = {
			enable = true;
			useBabelfish = true;
		};
		java = {
			enable = true;
			binfmt = true;
		};
		neovim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
			configure = {
				customRC = ''
					set ts=4 sw=4
				'';
			};
		};
		thunar = {
			enable = true;
			plugins = with pkgs.xfce; [
				thunar-volman
				thunar-archive-plugin
			];
		};
		ssh = {
			startAgent = false;
		};

		ns-usbloader.enable = true;
		git.enable = true;
		gnome-disks.enable = true;
		htop.enable = true;
		direnv.enable = true;
		light.enable = true;
	};

	services = {
		actkbd = {
			enable = true;
			bindings = [
      			{ keys = [ 224 ]; events = [ "key" ]; command = "${pkgs.light}/bin/light -U 10"; }
				{ keys = [ 225 ]; events = [ "key" ]; command = "${pkgs.light}/bin/light -A 10"; }
    		];
		};
		udev.extraRules = ''
			ACTION=="remove",\
       			ENV{ID_BUS}=="usb",\
				ENV{ID_MODEL_ID}=="0407",\
				ENV{ID_VENDOR_ID}=="1050",\
				ENV{ID_VENDOR}=="Yubico",\
				RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"

			ACTION=="add",\
       			ENV{ID_BUS}=="usb",\
				ENV{ID_MODEL_ID}=="0407",\
				ENV{ID_VENDOR_ID}=="1050",\
				ENV{ID_VENDOR}=="Yubico",\
				RUN+="${pkgs.systemd}/bin/loginctl unlock-sessions"
		'';
	};

	users = {
		defaultUserShell = pkgs.fish;
		users.moxie = {
			isNormalUser = true;
			extraGroups = [
				"wheel"
				"plugdev"
				"tss"
			];
			home = "/home/moxie";
		};
	};
	
	nix.settings = {
		experimental-features = [ "nix-command" "flakes" ];
	};

	nixpkgs= {
		config = {
			allowUnfree = true;
		};
    };

	system.stateVersion = "23.05"; # Did you read the comment?
}

