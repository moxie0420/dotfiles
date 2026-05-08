{den, ...}: {
  den.aspects.gaming = {
    includes = [
      (den.provides.unfree ["steam" "steam-original" "steam-unwrapped" "steam-run"])
    ];

    provides.extraLaunchers = {
      nixos = {pkgs, ...}: {
        environment.systemPackages = builtins.attrValues {
          inherit
            (pkgs)
            heroic
            olympus
            r2modman
            ;

          prismlauncher = pkgs.prismlauncher.override {
            jdks = builtins.attrValues {
              inherit
                (pkgs)
                temurin-bin-21
                temurin-bin-17
                temurin-bin-8
                ;
            };
          };
        };
      };
      homeManager = {pkgs, ...}: {
        home.packages = builtins.attrValues {
          inherit
            (pkgs)
            heroic
            olympus
            r2modman
            ;

          prismlauncher = pkgs.prismlauncher.override {
            jdks = builtins.attrValues {
              inherit
                (pkgs)
                temurin-bin-21
                temurin-bin-17
                temurin-bin-8
                ;
            };
          };
        };
      };
    };

    homeManager.programs.mangohud = {
      enable = true;

      settings = {
        position = "top-right";

        # FPS
        fps_sampling_period = 1000;
        fps_limit = "144,120,90,60,0";
        fps_limit_method = "early";

        # Other
        permit_upload = false;
        preset = 1;
      };
    };

    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) protonup-ng;
      };

      programs.gamemode = {
        enable = true;
        settings = {
          general = {
            softrealtime = "auto";
            renice = -5;
          };

          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0;
            nv_powermizer_mode = 1;

            nv_core_clock_mhz_offset = 200;
            nv_mem_clock_mhz_offset = 200;
          };
        };
      };

      programs.gamescope = {
        enable = true;
        capSysNice = true;
        args = ["--rt"];
      };

      programs.steam = {
        enable = true;

        gamescopeSession.enable = true;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;

        extraCompatPackages = builtins.attrValues {
          inherit (pkgs) proton-ge-bin;
        };
      };
    };
  };
}
