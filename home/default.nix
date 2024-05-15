{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    #inputs.hypridle.homeManagerModules.default
    #inputs.hyprlock.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.default
    ./hyprland.nix
    ./style.nix
    ./thunderbird.nix
  ];

  dconf = {
    enable = true;
    settings = {
    };
  };

  home = {
    username = "moxie";
    homeDirectory = "/home/moxie";

    packages = with pkgs; [
      alejandra
      qbittorrent

      #gaming
      heroic
      r2modman
      lutris
      prismlauncher

      yubikey-manager
      pavucontrol

      # for pandoc
      texliveFull

      osu-lazer-bin

      #(callPackage ../pkgs/ue5.nix {})
      cmatrix
      libreoffice-fresh
      reaper

      devenv
      coder
    ];

    stateVersion = "23.11";
  };
  programs = {
    home-manager.enable = true;
    feh.enable = true;

    # terminal config
    fish = {
      enable = true;
      shellInit = ''
        export XDG_DATA_HOME="$HOME/.local/share"
        zoxide init fish  --cmd cd | source
      '';
    };
    nushell = {
      enable = true;
      package = pkgs.nushellFull;
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

    # school
    pandoc = {
      enable = true;
      defaults = {
        metadata = {
          author = "Moxie Benavides";
          lang = "en-US";
        };
        pdf-engine = "xelatex";
        citeproc = false;
      };
      citationStyles = [./modern-language-association.csl];
    };
    neovim = {
      extraConfig = ''
        set tabstop=4
        set softtabstop=0 noexpandtab
        set shiftwidth=4
      '';
      plugins = with pkgs.vimPlugins; [
        vim-pandoc
        vim-pandoc-syntax
      ];
    };

    # show off stuff
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

    # obs
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        wlrobs
      ];
    };

    # coding stuff
    vscode = {
      enable = true;
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = false;
      mutableExtensionsDir = lib.mkForce true;
      package = pkgs.vscode;
      userSettings = {
        "window.titleBarStyle" = "custom";
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
        "git.terminalAuthentication" = true;
        "workbench.colorTheme" = lib.mkForce "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
        "telemetry.enableTelemetry" = false;
        "search.exclude" = {
          "**/node_modules" = true;
          "**/bower_components" = true;
          "**/env" = true;
          "**/venv" = true;
        };
        "files.watcherExclude" = {
          "**/.git/objects/**" = true;
          "**/.git/subtree-cache/**" = true;
          "**/node_modules/**" = true;
          "**/env/**" = true;
          "**/venv/**" = true;
          "env-*" = true;
        };
        "files.exclude" = {
          "**/.git" = true;
          "**/.DS_Store" = true;
          "**/__pycache__" = true;
          "**/.pytest_cache" = true;
          "**/node_modules" = true;
          "venv" = true;
          "*.sublime-*" = true;
          "env*" = true;
        };
      };
    };
    git = {
      enable = true;
      lfs.enable = true;
      userName = "Moxie Benavides";
      userEmail = "moxie@moxiege.com";
      extraConfig = {
        safe = {
          directory = "*";
        };
        init = {
          defaultBranch = "master";
        };
      };
    };

    # spotify theme
    spicetify = {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
      ];
    };

    /*
      hyprlock = {
      enable = true;
      backgrounds = [
        {
          monitor = "eDP-1";
          path = "/etc/nixos/wallpapers/lain.png";
        }
      ];
      input-fields = [
        {
          monitor = "eDP-1";
        }
      ];
    };
    */
  };
  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      sshKeys = [
        "C02F30F9FD65E05531A321C8491E3EFE1C0C7383"
      ];
    };
    #hypridle = {
    #  enable = true;
    #  lockCmd = "${inputs.hyprlock.packages.x86_64-linux.hyprlock}/bin/hyprlock";
    #  unlockCmd = "pkill -USR1 hyprlock";
    #  beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
    #};
  };
  xdg = {
    enable = true;
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
