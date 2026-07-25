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
      cacheHome = "${home}/.cache";
      configHome = "${home}/.config";
      dataHome = "${home}/.local/share";
      portal.xdgOpenUsePortal = true;
      stateHome = "${home}/.local/state";
      userDirs = {
        enable = pkgs.stdenv.isLinux;
        createDirectories = true;
        # Not really used but defined for completeness.
        desktop = "${home}/Desktop";
        # Bread and butter.
        documents = "${home}/Documents";
        download = "${home}/Downloads";
        # Specialized.
        extraConfig = {
          REPO = "${home}/src"; # Git clones of various projects.
          SCREENSHOTS = "${home}/Pictures/screenshots"; # Separates screenshots from regular pictures.
        };
        # Media.
        music = "${home}/Music";
        pictures = "${home}/Pictures";
        publicShare = "${home}/Public";
        setSessionVariables = false;
        templates = "${home}/Templates";
        videos = "${home}/Videos";
      };
    };
  };
}
