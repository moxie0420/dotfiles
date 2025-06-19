{
  config,
  inputs,
  lib,
  pkgs,
  self,
  ...
}: let
  inherit (self.packages.${pkgs.system}) rose-pine-kitty;
in {
  imports = [inputs.nix-index-database.hmModules.nix-index];

  home.packages = [pkgs.vivid];

  programs = {
    bottom.enable = true;

    btop = {
      enable = true;
      settings = {
        #color_theme = "TTY";
        theme_background = false;
      };
    };

    carapace.enable = true;

    hyfetch = {
      enable = true;
      settings = {
        preset = "transgender";
        mode = "rgb";
        color_align = {
          mode = "horizontal";
        };
      };
    };

    kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        background_opacity = lib.mkForce "0.0";
      };
      extraConfig = ''
        include ${rose-pine-kitty}/themes/rose-pine.conf
      '';
    };

    nix-index.enable = true;

    nushell = {
      enable = true;

      envFile.source = ../files/nushell/env.nu;

      extraConfig = let
        commandNotFound = pkgs.replaceVarsWith {
          name = "command-not-found";
          dir = "bin";
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/fe51d34885f7b5e3e7b59572796e1bcb427eccb1/nixos/modules/programs/command-not-found/command-not-found.pl";
            hash = "sha256-ZhF2PzN+nKUW2TXFMGltCxLJzNfoKUxEvRqhcLNsJZw=";
          };
          isExecutable = true;
          replacements = {
            inherit (config.programs.command-not-found) dbPath;
            perl = pkgs.perl.withPackages (p: [
              p.DBDSQLite
              p.StringShellQuote
            ]);
          };
        };
      in ''
        $env.config.hooks.command_not_found = {
          |command_name|
          print (${commandNotFound}/bin/command-not-found $command_name | str trim)
        }
      '';

      configFile.source = ../files/nushell/config.nu;
    };

    starship.enable = true;

    zoxide.enable = true;
  };
}
