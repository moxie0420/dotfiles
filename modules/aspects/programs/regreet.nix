{
  programs.regreet = {
    nixos = {
      lib,
      config,
      pkgs,
      ...
    }: let
      niriConfig = pkgs.writeText "regreet-niri-config" ''
        hotkey-overlay {
          skip-at-startup
        }

        environment {
          GTK_USE_PORTAL "0"
          GDK_DEBUG "no-portals"
        }

        output "HDMI-A-2" {
          focus-at-startup
        }

        spawn-at-startup "sh" "-c" "${pkgs.regreet}/bin/regreet; pkill -f niri"
      '';

      validatedConfig =
        pkgs.runCommand "validated-regreet-niri-config"
        {
          nativeBuildInputs = [config.programs.niri.package];
        }
        ''
          niri validate --config ${niriConfig}
          cp ${niriConfig} $out
        '';
    in {
      programs.regreet = {
        enable = true;
      };

      services.greetd.settings = {
        default_session = {
          command = lib.mkForce "${config.programs.niri.package}/bin/niri -c ${validatedConfig}";
        };

        terminal.vt = lib.mkForce 7;
      };
    };
  };
}
