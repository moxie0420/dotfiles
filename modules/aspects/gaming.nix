{den, ...}: {
  flake-file.inputs.nix-proton-cachyos.url = "github:kimjongbing/nix-proton-cachyos";

  den.aspects.gaming = {
    includes = [
      (den.provides.unfree ["steam" "steam-original" "steam-unwrapped" "steam-run"])
    ];

    extraLaunchers = {
      nixos = {pkgs, ...}: {
        environment.systemPackages = builtins.attrValues {
          inherit
            (pkgs)
            deadlock-mod-manager
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
            deadlock-mod-manager
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

    nixos = {
      # inputs',
      pkgs,
      ...
    }: {
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
        };
      };

      programs.steam = {
        enable = true;

        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;

        extraCompatPackages = builtins.attrValues {
          inherit (pkgs) proton-ge-bin;
          # inherit (inputs'.nix-proton-cachyos.packages) proton-cachyos;
        };
      };
    };
  };
}
