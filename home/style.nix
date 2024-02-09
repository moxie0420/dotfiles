{ config, pkgs, ...}:
{
    stylix = {
		cursor = {
			package = pkgs.catppuccin-cursors.mochaPink;
			name = "Catppuccin-Mocha-Pink-Cursors";
			size = 24;
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