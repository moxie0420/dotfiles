{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    plugins = [];

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;

      bg = mkLiteral "#191724";
      fgd = mkLiteral "#e0def4";
      cya = mkLiteral "#9ccfd8";
      grn = mkLiteral "#31748f";
      ora = mkLiteral "#ebbcba";
      red = mkLiteral "#eb6f92";

      foreground = fgd;
      background = bg;
      active-background = grn;
      urgent-background = red;

      selected-background = active-background;
      selected-urgent-background = urgent-background;
      selected-active-background = active-background;
      separatorcolor = active-background;
      bordercolor = ora;
    in {
      "*" = {
        font = "Cartograph CF 12";
        background-color = background;
      };

      "#window" = {
        background-color = background;
        border = 3;
        border-radius = 8;
        border-color = bordercolor;
        padding = 5;
      };

      "#mainbox" = {
        border = 0;
        padding = 5;
      };

      "#message" = {
        border = mkLiteral "1px dash 0px 0px";
        border-color = separatorcolor;
        padding = mkLiteral "1px";
      };

      "#textbox" = {
        text-color = foreground;
      };

      "#listview" = {
        fixed-height = 0;
        border = mkLiteral "2px dash 0px 0px";
        border-color = bordercolor;
        spacing = mkLiteral "2px";
        scrollbar = false;
        padding = mkLiteral "2px 0px 0px";
      };

      "#element" = {
        border = 0;
        padding = mkLiteral "1px";
      };

      "#element.normal.normal" = {
        background-color = background;
        text-color = foreground;
      };

      "#element.normal.urgent" = {
        background-color = urgent-background;
        text-color = foreground;
      };

      "#element.normal.active" = {
        background-color = active-background;
        text-color = background;
      };

      "#element.selected.normal" = {
        background-color = selected-background;
        text-color = foreground;
      };

      "#element.selected.urgent" = {
        background-color = selected-urgent-background;
        text-color = foreground;
      };

      "#element.selected.active" = {
        background-color = selected-active-background;
        text-color = background;
      };

      "#element.alternate.normal" = {
        background-color = background;
        text-color = foreground;
      };

      "#element.alternate.urgent" = {
        background-color = urgent-background;
        text-color = foreground;
      };

      "#element.alternate.active" = {
        background-color = active-background;
        text-color = foreground;
      };

      "#scrollbar" = {
        width = mkLiteral "2px";
        border = 0;
        handle-width = mkLiteral "8px";
        padding = 0;
      };

      "#sidebar" = {
        border = mkLiteral "2px dash 0px 0px";
        border-color = separatorcolor;
      };

      "#button.selected" = {
        background-color = selected-background;
        text-color = foreground;
      };

      "#inputbar" = {
        spacing = 0;
        text-color = foreground;
        padding = mkLiteral "1px";
      };

      "#case-indicator" = {
        spacing = 0;
        text-color = foreground;
      };
      "#entry" = {
        spacing = 0;
        text-color = cya;
      };
      "#prompt" = {
        spacing = 0;
        text-color = grn;
      };

      "#inputbar" = {
        children = map mkLiteral ["prompt" "textbox-prompt-colon" "entry" "case-indicator"];
      };

      "#textbox-prompt-colon" = {
        expand = false;
        str = ":";
        margin = mkLiteral "0px 0.3em 0em 0em";
        text-color = grn;
      };
    };
  };
}
