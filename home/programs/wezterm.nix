{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require('wezterm')
      local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main
      local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

      local rosePine = theme.colors()
      rosePine.background = "rgba(25, 23, 36, 50%)"

      local config = {}

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

      config.colors = rosePine
      config.window_frame = theme.window_frame()
      config.font_size = 11

      return config
    '';
  };
}
