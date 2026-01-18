let
  homeModules = {
    audioModule = import ./audio.nix;
    communicationModule = import ./communication.nix;
    desktop = import ./desktop.nix;
    shellModule = import ./shell.nix;
  };
in {
  default = {
    config,
    lib,
    pkgs,
    ...
  }:
    with lib; let
      cfg = config.moxie;
    in {
      imports = builtins.attrValues homeModules;

      options = {
        dotfiles = mkOption {
          type = types.path;
          apply = toString;
          default = "${config.home.homeDirectory}/dotfiles";
          example = "${config.home.homeDirectory}/.dotfiles";
          description = "Location of the dotfiles working copy";
        };

        moxie = {
          enable = mkEnableOption "enable my full home config";

          font = {
            name = mkOption {
              default = "Maple Mono NF CN";
              example = "Fira Code";
              type = types.str;
              description = ''
                The font to use throughout all my dots

                make sure that moxie.fonts.package includes the font set here
              '';
            };
            package = mkPackageOption pkgs ["maple-mono" "NF-CN"] {
              example = "pkgs.nerdfonts.fira-code";
            };
          };
        };
      };

      config = mkMerge [
        (mkIf cfg.enable {
          editorconfig = {
            enable = true;
            settings = {
              "*" = {
                charset = "utf-8";
                end_of_line = "lf";
                trim_trailing_whitespace = true;
                insert_final_newline = true;
                max_line_width = 78;
                indent_style = "space";
                indent_size = 2;
              };
            };
          };

          fonts.fontconfig = {
            antialiasing = true;
            subpixelRendering = mkDefault "rgb";
          };

          stylix = {
            enable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

            fonts = let
              userFont = {
                inherit (cfg.font) package name;
              };
            in {
              serif = userFont;
              sansSerif = userFont;
              monospace = userFont;
            };
          };
        })
      ];
    };
}
