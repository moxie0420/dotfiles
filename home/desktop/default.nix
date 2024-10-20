{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./lockscreen.nix
  ];
  catppuccin = {
    enable = true;
    accent = "pink";
    flavor = "mocha";
    pointerCursor.enable = lib.mkForce false;
  };

  home.packages = with pkgs; [
    nautilus
  ];

  qt.style.catppuccin = {
    enable = true;
    accent = "pink";
    flavor = "mocha";
  };
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      accent = "pink";
      flavor = "mocha";
      icon = {
        enable = true;
        accent = "pink";
        flavor = "mocha";
      };
    };
  };
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      "org/cinnamon/desktop/default-applications/terminal".exec = "kitty";
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
          gtk-application-prefer-dark-theme=1
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
      associations.added = {
        "x-scheme-handler/mailto" = "userapp-Thunderbird-JLKXS2.desktop";
        "x-scheme-handler/mid" = "userapp-Thunderbird-JLKXS2.desktop";
        "x-scheme-handler/news" = "userapp-Thunderbird-767TS2.desktop";
        "x-scheme-handler/snews" = "userapp-Thunderbird-767TS2.desktop";
        "x-scheme-handler/nntp" = "userapp-Thunderbird-767TS2.desktop";
        "x-scheme-handler/feed" = "userapp-Thunderbird-HY90S2.desktop";
        "application/rss+xml" = "userapp-Thunderbird-HY90S2.desktop";
        "application/x-extension-rss" = "userapp-Thunderbird-HY90S2.desktop";
        "x-scheme-handler/webcal" = "userapp-Thunderbird-SB92S2.desktop";
        "x-scheme-handler/webcals" = "userapp-Thunderbird-SB92S2.desktop";
      };
      defaultApplications = {
        "x-scheme-handler/bsplaylist" = ["BeatSaberModManager-url-bsplaylist.desktop"];
        "x-scheme-handler/modelsaber" = ["BeatSaberModManager-url-modelsaber.desktop"];
        "x-scheme-handler/beatsaver" = ["BeatSaberModManager-url-beatsaver.desktop"];
        "x-scheme-handler/everest" = ["Olympus.desktop"];
        "x-scheme-handler/ror2mm" = ["r2modman.desktop"];

        "image/png" = ["feh.desktop"];
        "image/jpeg" = ["feh.desktop"];
        "image/gif" = ["feh.desktop"];
        "application/pdf" = ["zen.desktop"];
        "inode/directory" = ["nautilus.desktop"];
        "application/x-gnome-saved-search" = ["nautilus.desktop"];

        "x-scheme-handler/http" = ["zen.dektop"];
        "x-scheme-handler/https" = ["zen.dektop"];
        "x-scheme-handler/chrome" = ["zen.dektop"];
        "text/html" = ["zen.desktop"];
        "application/x-extension-htm" = ["zen.dektop"];
        "application/x-extension-html" = ["zen.dektop"];
        "application/x-extension-shtml" = ["zen.dektop"];
        "application/xhtml+xml" = ["zen.dektop"];
        "application/x-extension-xhtml" = ["zen.dektop"];
        "application/x-extension-xht" = ["zen.dektop"];

        "application/zip" = ["org.gnome.FileRoller.desktop"];
        "application/7zip" = ["org.gnome.FileRoller.desktop"];
        "application/rar" = ["org.gnome.FileRoller.desktop"];

        "x-scheme-handler/mailto" = ["userapp-Thunderbird-JLKXS2.desktop"];
        "message/rfc822" = ["userapp-Thunderbird-JLKXS2.desktop"];
        "x-scheme-handler/mid" = ["userapp-Thunderbird-JLKXS2.desktop"];
        "x-scheme-handler/news" = ["userapp-Thunderbird-767TS2.desktop"];
        "x-scheme-handler/snews" = ["userapp-Thunderbird-767TS2.desktop"];
        "x-scheme-handler/nntp" = ["userapp-Thunderbird-767TS2.desktop"];
        "x-scheme-handler/feed" = ["userapp-Thunderbird-HY90S2.desktop"];
        "application/rss+xml" = ["userapp-Thunderbird-HY90S2.desktop"];
        "application/x-extension-rss" = ["userapp-Thunderbird-HY90S2.desktop"];
        "x-scheme-handler/webcal" = ["userapp-Thunderbird-SB92S2.desktop"];
        "text/calendar" = ["userapp-Thunderbird-SB92S2.desktop"];
        "application/x-extension-ics" = ["userapp-Thunderbird-SB92S2.desktop"];
        "x-scheme-handler/webcals" = ["userapp-Thunderbird-SB92S2.desktop"];
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
