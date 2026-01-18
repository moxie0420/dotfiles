{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.moxie.desktop;
in {
  options.moxie.desktop = {
    enable = mkEnableOption "Enables my Desktop Setup";
    communication.enable = mkEnableOption "Enable discord, qbittorrent, and similar software";
    cursor.enable = mkEnableOption "Set the system cursor to rose-pine";
    fileManager.enable = mkEnableOption "Enable Nautilus";
    fonts.enable = mkEnableOption "Set the system font to maplemono";
    gaming = {
      enable = mkEnableOption "Enable steam, wine, and heroic";
      gamescopeArgs = mkOption {
        default = [""];
        example = ''
          [
            "-W 1920"
            "-H 1080"
          ]
        '';
      };
    };
    music.enable = mkEnableOption "Enable RMPC, beets and other music adjacent software";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      moxie.desktop = {
        communication.enable = mkDefault true;
        cursor.enable = mkDefault true;
        fonts.enable = mkDefault true;
        fileManager.enable = mkDefault true;
        gaming.enable = mkDefault true;
        music.enable = mkDefault true;
      };

      environment = {
        pathsToLink = ["/share/icons"];
        systemPackages = with pkgs; [
          aria2
          baobab
          firefox
          hyprpicker
          hyprshot
          hyprsunset
          nautilus
          nautilus-open-any-terminal
          rose-pine-gtk-theme
          rose-pine-icon-theme
          wezterm
          wineWowPackages.stable
        ];
      };

      programs = {
        dconf = {
          enable = mkForce true;
          profiles.user.databases = [
            {
              settings = {
                "org/cinnamon/desktop/default-applications/terminal".exec = "wezterm";
                "org/gnome/mutter".experimental-features = ["variable-refresh-rate"];
                "org/gnome/desktop/interface" = {
                  color-scheme = "prefer-dark";
                };
              };
            }
          ];
        };
        firefox.enable = true;
        gnome-disks.enable = true;
        hyprland = {
          enable = true;
          package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default;
          portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        };
        seahorse.enable = true;
      };

      services = {
        dbus = {
          implementation = "broker";
          packages = with pkgs; [
            gcr
            gnome-settings-daemon
          ];
        };
        flatpak.enable = true;
        gnome.gnome-keyring.enable = true;
        gvfs.enable = true;
      };

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        config = {
          common.default = ["hyprland" "gtk"];
          hyprland.default = ["hyprland" "gtk"];
        };

        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];
      };
    })

    (mkIf cfg.communication.enable {
      environment.systemPackages = with pkgs; [
        qbittorrent-enhanced
        vesktop
      ];

      xdg.mime.defaultApplications = {
        "application/x-bittorrent" = "qbittorrent.desktop";
      };
    })

    (mkIf cfg.cursor.enable {
      environment = {
        systemPackages = with pkgs; [
          rose-pine-hyprcursor
        ];
        variables = {
          HYPRCURSOR_SIZE = 24;
          HYPRCURSOR_THEME = "rose-pine-hyprcursor";
        };
      };
      programs.dconf = {
        profiles = {
          gdm.databases = [
            {
              settings = {
                "org/gnome/desktop/interface" = {
                  cursor-theme = "rose-pine";
                  cursor-size = "24";
                };
              };
            }
          ];
        };
      };

      stylix.cursor = {
        package = pkgs.rose-pine-cursor;
        name = "rose-pine";
        size = 24;
      };
    })

    (mkIf cfg.fileManager.enable {
      environment = {
        pathsToLink = ["share/thumbnailers"];
        systemPackages = with pkgs; [
          libheif
          libheif.out
          file-roller
        ];
      };
      programs = {
        nautilus-open-any-terminal = {
          enable = true;
          terminal = "wezterm";
        };
      };
      services.gnome.sushi.enable = true;
    })

    (mkIf cfg.fonts.enable {
      fonts.packages = attrValues {
        inherit (pkgs) material-symbols;
        inherit (pkgs) noto-fonts noto-fonts-color-emoji noto-fonts-cjk-sans;
      };

      stylix.fonts = let
        mapleMono = {
          package = pkgs.maple-mono.NF-CN;
          name = "Maple Mono NF CN";
        };
      in {
        serif = mapleMono;
        sansSerif = mapleMono;
        monospace = mapleMono;
      };
    })

    (mkIf cfg.gaming.enable {
      environment.systemPackages = with pkgs; let
        prismlauncher = pkgs.prismlauncher.override {
          jdks = [temurin-bin-21 temurin-bin-17 temurin-bin-8];
        };
      in [
        heroic
        olympus
        prismlauncher
        r2modman
        mangohud
        theclicker
      ];
      programs = {
        gamemode.enable = true;
        gamescope = {
          enable = true;
          capSysNice = true;
          args = lib.flatten cfg.gaming.gamescopeArgs;
        };
        steam = {
          enable = true;
          localNetworkGameTransfers.openFirewall = true;
          protontricks.enable = true;
          remotePlay.openFirewall = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
      };
    })

    (mkIf cfg.music.enable {
      environment.systemPackages = with pkgs; [
        cava
        cyanrip
        rmpc-git
      ];
    })
  ];
}
