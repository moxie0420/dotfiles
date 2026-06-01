{
  programs.kitty = {
    homeManager = {
      programs.kitty = {
        enable = true;
        enableGitIntegration = true;

        extraConfig = ''
          map ctrl+t new_tab_with_cwd
        '';
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
  };
}
