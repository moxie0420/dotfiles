{
  desktop.launcher.homeManager = {
    # config,
    # lib,
    ...
  }:
  # let
  #   inherit (config.lib.formats.rasi) mkLiteral;
  # in
  {
    programs = {
      # programs.rofi = {
      #   enable = true;
      #   plugins = [];
      #   theme = lib.mkAfter {
      #     window = {
      #       border-radius = mkLiteral "16px";
      #       border = mkLiteral "2px";
      #       padding = mkLiteral "8px";
      #     };
      #   };
      # };
      fuzzel.enable = true;

      # niri intergration
      niri.settings.binds = {
        # "Mod+Space".action.spawn = ["rofi" "-matching" "glob" "-show" "drun" "-show-icons"];
        "Mod+Space".action.spawn = ["fuzzel"];
      };
    };
  };
}
