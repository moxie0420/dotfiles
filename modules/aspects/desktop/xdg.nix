{
  desktop.xdg.homeManager = {
    config,
    pkgs,
    ...
  }: let
    home = config.home.homeDirectory;
  in {
    # Make programs use XDG directories whenever supported.
    home.preferXdgDirectories = true;

    xdg = {
      enable = true;
      portal = {
        enable = true;
        extraPortals = builtins.attrValues {
          inherit (pkgs) xdg-desktop-portal-gnome;
        };

        config.common.default = "*";
      };

      configHome = "${home}/.config";
      dataHome = "${home}/.local/share";
      cacheHome = "${home}/.cache";
      stateHome = "${home}/.local/state";

      userDirs = {
        enable = pkgs.stdenv.isLinux;
        createDirectories = true;
        setSessionVariables = false;

        # Bread and butter.
        documents = "${home}/Documents";
        download = "${home}/Downloads";

        # Media.
        music = "${home}/Music";
        pictures = "${home}/Pictures";
        videos = "${home}/Videos";

        # Not really used but defined for completeness.
        desktop = "${home}/Desktop";
        publicShare = "${home}/Public";
        templates = "${home}/Templates";

        # Specialized.
        extraConfig = {
          REPO = "${home}/src"; # Git clones of various projects.
          SCREENSHOTS = "${home}/Pictures/screenshots"; # Separates screenshots from regular pictures.
        };
      };
    };
  };
}
