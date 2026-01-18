{lib', ...}:
with lib'.hyprland; {
  wayland.windowManager.hyprland.extraConfig = let
    patterns = {
      proton = "^(steam_app_([0-9]*))$";
      steam = {
        class = "^(steam)$";
        title = "^(Steam)$";
      };
      vesktop = "^(vesktop)$";
      wow = "^(World of Warcraft)$";
    };

    rules = [
      (mkWindowRule
        {
          name = "Float_Steam_windows";
          props = mkClass patterns.steam.class;
          effects.float = "true";
        })
      (mkWindowRule {
        name = "Tile_main_steam_window";
        props = [
          (mkClass patterns.steam.class)
          (mkTitle patterns.steam.title)
        ];
        effects.tile = "true";
      })

      (mkWindowRule {
        name = "Fix_xwayland_dragging";
        props = let
          pattern = "^$";
        in [
          (mkClass pattern)
          (mkTitle pattern)
          (mkXwayland "true")
          (mkFloat "true")
          (mkFullscreen "false")
          (mkPin "false")
        ];
        effects.no_focus = "true";
      })

      (mkWindowRule {
        name = "Vesktop_rules";
        props = mkClass patterns.vesktop;
        effects.workspace = 8;
      })

      (mkWindowRule {
        name = "WOW_rules";
        props = mkTitle patterns.wow;
        effects = {
          fullscreen = "true";
          workspace = "7";
        };
      })

      (mkWindowRule {
        name = "fullscreen_proton";
        props = mkClass patterns.proton;
        effects = {
          content = "game";
          fullscreen = "true";
        };
      })

      (mkWindowRule {
        name = "float_qbittorent_import_window";
        props = [
          (mkClass "^(org.qbittorrent.qBittorrent)$")
          (mkTitle "^(Magnet link)$")
        ];
        effects.float = "true";
      })

      (mkWindowRule {
        name = "float_polkit_prompt";
        props = [
          (mkTitle "^(Authentication Required)$")
          (mkClass "^()$")
        ];
        effects.float = "true";
      })
    ];
  in
    lib'.toLines rules;
}
