{ config, pkgs, ...}:
{
    stylix = {
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