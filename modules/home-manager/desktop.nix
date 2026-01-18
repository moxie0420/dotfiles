{
  config,
  lib,
  lib',
  pkgs,
  ...
}:
with lib; let
  cfg = config.moxie.desktop;
in {
  options.moxie.desktop = let
    inherit (lib') mkEnabledOption mkFollowsOption;
  in {
    enableBinds = mkEnabledOption "binds";
    enableWindowRules = mkEnabledOption "window rules";

    clipboard = {
      enable = mkEnabledOption "clipboard management";
      withBinds = mkFollowsOption cfg.enableBinds;
      withWindowRules = mkFollowsOption cfg.enableWindowRules;
    };

    terminal = mkPackageOption pkgs "wezterm" {
      example = "pkgs.kitty";
      extraDescription = ''
        set the default terminal
      '';
    };
  };

  config = mkMerge [
    (mkIf cfg.clipboard.enable {
      services.clipse.enable = true;

      wayland.windowManager.hyprland.settings = {
        bind = mkIf cfg.clipboard.withBinds [
          "CTRL SUPER, V, exec, ${getBin cfg.terminal} --class clipse -e clipse"
        ];
        windowrule = mkIf cfg.clipboard.withWindowRules [
          # Float in the middle for clipse clipboard manager
          "match:class ^(clipse)$, float true"
          "match:class ^(clipse)$, size 622 652"
          "match:class ^(clipse)$, stay_focused true"
        ];
      };
    })
  ];
}
