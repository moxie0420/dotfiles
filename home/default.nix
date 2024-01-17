{ config, pkgs, spicetify-nix, ... }:
let
	spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
	imports = [ 
		spicetify-nix.homeManagerModule
		./style.nix
		./hyprland.nix
	];

	home = {
		username = "moxie";
		homeDirectory = "/home/moxie";

		packages = with pkgs; [
			fritzing
			arduino-ide
			baobab
			qbittorrent
            heroic
		    r2modman
			zstd
			vulkan-tools
			qbittorrent
			yubikey-manager
			# to be thinned when laptop is added
      		pavucontrol
	      	(pkgs.prismlauncher.override {
				additionalLibs = with pkgs; [ glfw-wayland ];
				additionalPrograms = with pkgs; [ gamescope ];
			})
      		hyprpaper
			lutris
			p7zip
			unzip
			zip
		];

		stateVersion = "23.11";
	};
	programs = {
		feh.enable = true;

		# terminal config
		fish.enable = true;
		kitty = {
			enable = true;
			shellIntegration.enableFishIntegration = true;
		};

		#s chool
		pandoc = {
			enable = true;
			#TODO
		};
		neovim = {
			extraConfig = ''
				set tabstop=4
				set softtabstop=0 noexpandtab
				set shiftwidth=4
			'';
			plugins = with pkgs.vimPlugins; [
				vim-pandoc
				vim-pandoc-syntax
			];
		};

		# show off stuff
		bottom.enable = true;
		hyfetch = {
			enable = true;
			settings = {
				preset = "transgender";
    				mode = "rgb";
				light_dark = "dark";
				lightness = 0.75;
				color_align = {
					mode = "horizontal";
					custom_colors = [];
					fore_back = null;
				};
				backend = "neofetch";
				args = null;
				distro = null;
				pride_month_shown = [];
				pride_month_disable = false;
			};
		};

		# obs
		obs-studio = {
			enable = true;
			plugins = with pkgs.obs-studio-plugins; [
     			    wlrobs
    			]; 
		};

		# coding stuff
		vscode = {
			enable = true;
			extensions = with pkgs.vscode-extensions; [
				catppuccin.catppuccin-vsc
				catppuccin.catppuccin-vsc-icons
				mkhl.direnv
				ms-vscode.makefile-tools
				ms-vscode.cpptools
			];
			package = pkgs.vscode;
			userSettings = {
         			"window.titleBarStyle" = "custom";
					"git.enableSmartCommit" = true;
					"git.confirmSync" = false;
					"workbench.colorTheme" = "Catppuccin Mocha";
  					"workbench.iconTheme" = "catppuccin-mocha";
      		};
		};
		git = {
			enable = true;
			lfs.enable = true;
			userName = "Moxie Benavides";
			userEmail = "ethanpbenavides@gmail.com";
			extraConfig = {
				safe = {
					directory = "*";
				};
			};
		};
		
		# spotify theme
		spicetify = {
      		enable = true;
      		theme = spicePkgs.themes.catppuccin;
      		colorScheme = "mocha";
      		enabledExtensions = with spicePkgs.extensions; [
        		fullAppDisplay
        		shuffle # shuffle+ (special characters are sanitized out of ext names)
        		hidePodcasts
      		];
    	};
	};
	services = {
		dunst.enable = true;
		gpg-agent = {
			enable = true;
			enableSshSupport = true;
		};
		swayidle = {
			enable = true;
			systemdTarget = "hyprland-session.target";
			events = [
				{ event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -S --clock --indicator-idle-visible --effect-blur 5x7"; }
				{ event = "lock"; command = "${pkgs.swaylock-effects}/bin/swaylock -S --clock --indicator-idle-visible --effect-blur 5x7"; }
			];
		};
	};
	xdg = {
		enable = true;
		desktopEntries = {
			feh = {
				name = "Feh";
				genericName = "Image Viewer";
				exec = "feh --scale-down";
				terminal = false;
				mimeType = [ "image/jpeg" "image/png" ];
			};
		};
		mime.enable = true;
		mimeApps = {
			enable = true;
			defaultApplications = {
				"x-scheme-handler/bsplaylist" = [ "BeatSaberModManager-url-bsplaylist.desktop" ];
				"x-scheme-handler/modelsaber" = [ "BeatSaberModManager-url-modelsaber.desktop" ];
				"x-scheme-handler/beatsaver" = [ "BeatSaberModManager-url-beatsaver.desktop" ];
				"x-scheme-handler/everest" = [ "Olympus.desktop" ];
				"x-scheme-handler/ror2mm" = [ "r2modman.desktop" ];
				"image/png" = [ "feh.desktop" ];
				"image/jpeg" = [ "feh.desktop" ];
				"image/gif" = [ "feh.desktop" ];
				"application/pdf" = [ "firefox.desktop" ];
				"inode/directory" = [ "thunar.desktop" ];
				"x-scheme-handler/http" = [ "firefox.dektop" ];
				"x-scheme-handler/https" = [ "firefox.dektop" ];
				"x-scheme-handler/chrome" = [ "firefox.dektop" ];
				"text/html" = [ "firefox.desktop" ];
				"application/x-extension-htm" = [ "firefox.dektop" ];
				"application/x-extension-html" = [ "firefox.dektop" ];
				"application/x-extension-shtml" = [ "firefox.dektop" ];
				"application/xhtml+xml" = [ "firefox.dektop" ];
				"application/x-extension-xhtml" = [ "firefox.dektop" ];
				"application/x-extension-xht" = [ "firefox.dektop" ];
			};
			associations.added = {
				"text/x-ms-regedit" = [ "wine-extension-txt.desktop" "nvim.desktop" ];
				"application/zip" = [ "org.gnome.FileRoller.desktop" ];
			};
		};
		userDirs = {
			enable = true;
			createDirectories = true;
		};
		configFile = {
			
		};
	};
}
