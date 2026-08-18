{
  flake-file.inputs.nix-gaming-edge = {
    url = "github:powerofthe69/nix-gaming-edge";
  };

  programs.steam = {
    homeManager = {config, ...}: {
      xdg.configFile."openxr/1/active_runtime.json".text = ''
        {
           "file_format_version": "1.0.0",
            "runtime": {
            "VALVE_runtime_is_steamvr": true,
            "library_path": "${config.home.homeDirectory}/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrclient.so",
            "name": "SteamVR"
            }
        }
      '';
    };

    nixos = {pkgs, ...}: {
      environment.systemPackages = [pkgs.wayvr];

      programs.steam = {
        enable = true;

        extraCompatPackages = builtins.attrValues {
          inherit (pkgs) proton-cachyos-x86_64-v3;
        };

        localNetworkGameTransfers.openFirewall = true;

        package = pkgs.steam.override {
          extraEnv = {
            VK_ADD_LAYER_PATH = "${pkgs.steamvr-linux-fixes}/lib/libsteamvr_linux_fixes.so";
            VK_INSTANCE_LAYERS = "VK_LAYER_BNUUY_steamvr_linux_fixes";
          };

          extraPkgs = pkgs':
            with pkgs'; [
              libXcursor
              libXi
              libXinerama
              libXScrnSaver
              libpng
              libpulseaudio
              libvorbis
              stdenv.cc.cc.lib # Provides libstdc++.so.6
              libkrb5
              keyutils
              # Add other libraries as needed
            ];
        };

        protontricks.enable = true;
        remotePlay.openFirewall = true;
      };
    };
  };
}
