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
			xwaylandvideobridge
            heroic
		    r2modman

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
			neofetch
			lutris
		    (wrapOBS {
    			plugins = with pkgs.obs-studio-plugins; [
     			    wlrobs
      			    obs-backgroundremoval
      			    obs-pipewire-audio-capture
    			];
  		    })
		];

		stateVersion = "23.11";
	};
	programs = {
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