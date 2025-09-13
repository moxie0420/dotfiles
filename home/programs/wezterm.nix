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
      config.font = wezterm.font {
        family = 'Maple Mono NF CN',
        weight = 500,
        harfbuzz_features = { 'calt', 'ss03','ss10', 'ss11', 'zero'},
      }


      return config
    '';
  };
}
