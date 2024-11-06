{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
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
    };

    nix-index.enable = true;

    nushell = {
      enable = true;

      envFile.source = ../files/nushell/env.nu;

      extraConfig = let
        cfg = config.programs.command-not-found;
        commandNotFound = pkgs.substituteAll {
          name = "command-not-found";
          dir = "bin";
          src = pkgs.fetchurl {
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/7eee17a8a5868ecf596bbb8c8beb527253ea8f4d/nixos/modules/programs/command-not-found/command-not-found.pl";
            hash = "sha256-ZhF2PzN+nKUW2TXFMGltCxLJzNfoKUxEvRqhcLNsJZw=";
          };
          isExecutable = true;
          inherit (cfg) dbPath;
          perl = pkgs.perl.withPackages (p: [p.DBDSQLite p.StringShellQuote]);
        };
      in ''
        $env.config.hooks.command_not_found = {
          |cmd_name| (
            try {
              let pkgs = (${commandNotFound}/bin/command-not-found $cmd_name)
              return $pkgs
            }
          )
        }
      '';

      configFile.source = ../files/nushell/config.nu;
    };

    starship.enable = true;

    zoxide.enable = true;
  };
}
