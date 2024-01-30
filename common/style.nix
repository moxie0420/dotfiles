{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		hyprpaper
	];

	stylix = {
		base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
		polarity = "dark";

		image = ../wallpapers/cyber.png;
		
		cursor = {
			package = pkgs.catppuccin-cursors;
			name = "mochaPink";
		};
		
		fonts = {
			emoji = {
				package = pkgs.noto-fonts-emoji;
				name = "Noto Color Emoji";
			};
			monospace = {
				package = pkgs.nerdfonts;
				name = "ComicShannsMono";
			};
			serif = config.stylix.fonts.monospace;
    			sansSerif = config.stylix.fonts.monospace;
		};
	};
}
