{lib, ...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = lib.mkAfter ''
      local config = {}
      local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

      bar.apply_to_config(config, {
        modules = {
          workspace = {
            enabled = false
          },
          pane = {
            enabled = false
          },
          cwd = {
            enabled = false
          }
        }
      })

      config.window_background_opacity = 0.50
      config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0
      }
      config.font_size = 10

      return config
    '';
  };
}
