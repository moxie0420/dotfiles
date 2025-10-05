{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.moxie.development;
in {
  options.moxie.development = {
    enable = mkEnableOption "enable development envitonment";
    name = mkOption {
      type = types.str;
      default = "";
      description = "a name for git to use";
    };
    email = mkOption {
      type = types.str;
      default = "";
      description = "an email for git to use";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      devenv
      direnv
      git
      gh
      lazydocker
      lazygit
    ];

    programs = {
      fish.interactiveShellInit = ''
        direnv hook fish | source
      '';
      git = {
        enable = mkForce true;
        config = {
          credential.helper = mkDefault "store";
          init = {
            defaultBranch = mkDefault "master";
          };
          url."https://github.com/" = {
            insteadOf = ["gh:" "github:"];
          };
          user = {
            inherit (cfg) name email;
          };
        };
      };
      lazygit.enable = true;
    };

    services.lorri.enable = true;
  };
}
