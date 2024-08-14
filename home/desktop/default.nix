{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./lockscreen.nix
  ];

  home = {
    packages = with pkgs; [
      nwg-look
    ];
  };

  dconf = {
    enable = true;
    settings = {
    };
  };

  xdg = {
    enable = true;
    dataFile = {
      "icons/rose-pine-hyprcursor" = {
        recursive = true;
        source = ./files/rose-pine-hyprcursor;
      };
      "icons/rose-pine" = {
        recursive = true;
        source = ./files/rose-pine;
      };
      "icons/default" = {
        recursive = true;
        source = ./files/rose-pine;
      };
    };
    configFile = {
      "gtk-2.0/settings.ini" = {
        text = ''
          [Settings]
          gtk-cursor-theme-name=rose-pine
        '';
      };
      "gtk-3.0/settings.ini" = {
        text = ''
          [Settings]
          gtk-cursor-theme-name=rose-pine
        '';
      };
      "gtk-4.0/settings.ini" = {
        text = ''
          [Settings]
          gtk-cursor-theme-name=rose-pine
        '';
      };
    };
    desktopEntries = {
      feh = {
        name = "Feh";
        genericName = "Image Viewer";
        exec = "feh --scale-down";
        terminal = false;
        mimeType = ["image/jpeg" "image/png"];
      };
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/bsplaylist" = ["BeatSaberModManager-url-bsplaylist.desktop"];
        "x-scheme-handler/modelsaber" = ["BeatSaberModManager-url-modelsaber.desktop"];
        "x-scheme-handler/beatsaver" = ["BeatSaberModManager-url-beatsaver.desktop"];
        "x-scheme-handler/everest" = ["Olympus.desktop"];
        "x-scheme-handler/ror2mm" = ["r2modman.desktop"];
        "image/png" = ["feh.desktop"];
        "image/jpeg" = ["feh.desktop"];
        "image/gif" = ["feh.desktop"];
        "application/pdf" = ["firefox.desktop"];
        "inode/directory" = ["thunar.desktop"];
        "x-scheme-handler/http" = ["firefox.dektop"];
        "x-scheme-handler/https" = ["firefox.dektop"];
        "x-scheme-handler/chrome" = ["firefox.dektop"];
        "text/html" = ["firefox.desktop"];
        "application/x-extension-htm" = ["firefox.dektop"];
        "application/x-extension-html" = ["firefox.dektop"];
        "application/x-extension-shtml" = ["firefox.dektop"];
        "application/xhtml+xml" = ["firefox.dektop"];
        "application/x-extension-xhtml" = ["firefox.dektop"];
        "application/x-extension-xht" = ["firefox.dektop"];
        "application/zip" = ["org.gnome.FileRoller.desktop"];
        "application/7zip" = ["org.gnome.FileRoller.desktop"];
        "application/rar" = ["org.gnome.FileRoller.desktop"];
        "application/x-partial-download" = ["org.gnome.FileRoller.desktop"];
      };
      associations.added = {
        "text/x-ms-regedit" = ["wine-extension-txt.desktop" "nvim.desktop"];
        "application/zip" = ["org.gnome.FileRoller.desktop"];
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
