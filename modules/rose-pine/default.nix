{
  config,
  lib,
  ...
}: let
  cfg = config.rose-pine;
in {
  imports = [
    ./Cursor.nix
    ./hyprland.nix
    ./hyprpaper.nix
    ./kitty.nix
    ./spotify.nix
    ./starship.nix
    ./vesktop.nix
    ./wofi.nix
    ./zen.nix
  ];
  options.rose-pine = {
    enable = lib.mkEnableOption "enable rose-pine for all detected programs";
    cursor.enable = lib.mkEnableOption "enable rose-pine for xcursor and hyprcursor";
    gtk.enable = lib.mkEnableOption "enable rose-pine for gtk";
    hyprland.enable = lib.mkEnableOption "enable rose-pine for Hyprland";
    hyprpaper.enable = lib.mkEnableOption "enable rose-pine for Hyprpaper";
    kitty.enable = lib.mkEnableOption "enable rose-pine for Kitty";
    mako.enable = lib.mkEnableOption "enable rose-pine for Mako";
    spotify.enable = lib.mkEnableOption "enable rose-pine for spotify";
    starship.enable = lib.mkEnableOption "enable rose-pine for Starship";
    vesktop.enable = lib.mkEnableOption "enable rose-pine for Vesktop";
    wofi.enable = lib.mkEnableOption "enable rose-pine for Wofi";
    zen.enable = lib.mkEnableOption "enable rose-pine for Zen";
  };

  config.rose-pine = lib.mkIf cfg.enable {
    cursor.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    hyprpaper.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
    spotify.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    vesktop.enable = lib.mkDefault true;
    wofi.enable = lib.mkDefault true;
    zen.enable = lib.mkDefault true;
  };
}
