{
  desktop.niri.windowRules = {
    homeManager = {
      wayland.windowManager.niri.settings.window-rule = [
        {
          match._props.app-id._raw = ''r#"firefox$"# title="^Picture-in-Picture$"'';
          open-floating = true;
        }

        {
          block-out-from = "screen-capture";
          match._props.app-id._raw = ''r#"^org\.gnome\.World\.Secrets$"#'';
        }

        {
          clip-to-geometry = true;
          geometry-corner-radius = 12;
        }
      ];
    };
  };
}
