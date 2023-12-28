{ config, pkgs, spicetify-nix, ... }:
let
	spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
	imports = [ 
		spicetify-nix.homeManagerModule
	];

	home = {
		username = "moxie";
		homeDirectory = "/home/moxie";

		packages = with pkgs; [
			wlr-randr
			fritzing
			arduino-ide
			baobab
			qbittorrent
            heroic
		    r2modman
			zstd

			# to be thinned when laptop is added
			firefox
			neovim
	      	kitty
      		pavucontrol
      		waybar
	      	prismlauncher
      		hyprpaper
	      	wofi
	      	bottom
			lutris
			vulkan-tools
			vesktop
			tor-browser
		];

		stateVersion = "23.11";
	};
	programs = {
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
		obs-studio = {
			enable = true;
			plugins = with pkgs.obs-studio-plugins; [
     			    wlrobs
    			]; 
		};
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
		git = {
			enable = true;
			lfs.enable = true;
			userName = "Moxie Benavides";
			userEmail = "astronomicalgamer5@gmail.com";
			extraConfig = {
				safe = {
					directory = "*";
				};
			};
		};
	};
	services = {
		
	};
	xdg = {
		enable = true;
		mime.enable = true;
		mimeApps = {
			enable = true;
			defaultApplications = {
				"x-scheme-handler/bsplaylist" = [ "BeatSaberModManager-url-bsplaylist.desktop" ];
				"x-scheme-handler/modelsaber" = [ "BeatSaberModManager-url-modelsaber.desktop" ];
				"x-scheme-handler/beatsaver" = [ "BeatSaberModManager-url-beatsaver.desktop" ];
				"x-scheme-handler/everest" = [ "Olympus.desktop" ];
				"x-scheme-handler/ror2mm" = [ "r2modman.desktop" ];
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
