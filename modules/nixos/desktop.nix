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
    gaming.enable = mkEnableOption "Enable steam, wine, and heroic";
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
          rose-pine-gtk-theme
          rose-pine-icon-theme
          hyprpicker
          hyprshot
          hyprsunset
          wezterm
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
                  gtk-theme = "rose-pine";
                  icon-theme = "rose-pine";
                };
              };
            }
          ];
        };
        gnome-disks.enable = true;
        hyprland = {
          enable = true;
          withUWSM = true;

          package = inputs.hyprland.packages.${pkgs.system}.default;
          portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
        };
        seahorse.enable = true;
      };

      services = {
        ananicy = {
          enable = true;
          package = pkgs.ananicy-cpp;
          rulesProvider = pkgs.ananicy-rules-cachyos_git;
        };
        dbus = {
          implementation = "broker";
          packages = with pkgs; [
            gcr
            gnome-settings-daemon
          ];
        };

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
        ];
      };
      programs = {
        file-roller.enable = true;
        nautilus-open-any-terminal = {
          enable = true;
          terminal = "wezterm";
        };
      };
      services.gnome.sushi.enable = true;
    })

    (mkIf cfg.fonts.enable {
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
      ];
      programs.steam = {
        enable = true;
        package = pkgs.steam;

        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;

        extraCompatPackages = with pkgs; [
          proton-cachyos_x86_64_v3
        ];
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
