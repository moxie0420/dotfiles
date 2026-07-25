{programs, ...}: {
  programs.kitty = {
    homeManager = {lib, ...}: {
      home.shellAliases = {
        ssh = lib.mkDefault "kitten ssh";
      };

      programs.kitty = {
        enable = true;
        autoThemeFiles = {
          dark = "rose-pine";
          light = "rose-pine-dawn";
          noPreference = "rose-pine-moon";
        };
        enableGitIntegration = true;
        keybindings = {
          "ctrl+t" = "new_tab_with_cwd";
        };
        settings = {
          background_blur = 4;
          background_opacity = 0.4;

          font_size = 10;

          scrollback_lines = 10000;
          update_check_interval = 0;
        };
      };

      # niri intergration
      programs.niri.settings.binds = {
        "Mod+Return".action.spawn = ["kitty"];
      };
    };
    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) kitty kitty-img;
      };
    };
    provides = {
      to-hosts.includes = [programs.kitty];
      to-users.includes = [programs.kitty];
    };
  };
}
