{
  programs.kitty = {
    homeManager = {
      programs.kitty = {
        enable = true;
        enableGitIntegration = true;
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
