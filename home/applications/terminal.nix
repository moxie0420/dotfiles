{
  pkgs,
  lib,
  ...
}: {
  programs = {
    nushell = {
      enable = true;
      package = pkgs.nushell;
      envFile.text = ''
        zoxide init nushell | save -f ~/.zoxide.nu
      '';
      configFile.text = ''
        source ~/.zoxide.nu
      '';
    };
    kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        background_opacity = lib.mkForce "0.50";
      };
    };
    zoxide.enable = true;
    bottom.enable = true;
    btop = {
      enable = true;
      settings = {
        #color_theme = "TTY";
        theme_background = false;
      };
    };
    hyfetch = {
      enable = true;
      settings = {
        preset = "transgender";
        mode = "rgb";
        light_dark = "dark";
        lightness = 0.75;
        color_align = {
          mode = "horizontal";
          custom_colors = [];
          fore_back = null;
        };
        backend = "neofetch";
        args = null;
        distro = null;
        pride_month_shown = [];
        pride_month_disable = false;
      };
    };
  };
}
