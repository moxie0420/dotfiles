{
  desktop.dconf.nixos = {
    # config,
    # lib,
    # pkgs,
    ...
  }:
  # let
  # inherit (lib) genAttrs;
  # setDconfAttr = path: name: value: {
  #   settings.${path}.${name} = value;
  # };
  # setDefaultTerminal = path:
  #   setDconfAttr
  #   "org/cinnamon/desktop/default-applications/terminal"
  #   "exec"
  #   path;
  # cursorCfg = config.stylix.cursor;
  # in
  {
    programs.dconf = {
      enable = true;
      # profiles =
      #   genAttrs ["gdm" "user"]
      #   (name: {
      #     databases.settings."org/gnome/desktop/interface" = {
      #       color-scheme = "preferDark";
      #       cursor-size = toString cursorCfg.size;
      #       cursor-theme = cursorCfg.name;
      #     };
      #   })
      #   // {user.databases = setDefaultTerminal "${pkgs.kitty}/bin/kitty";};
    };
  };
}
