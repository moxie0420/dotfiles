{
  inputs,
  lib,
  pkgs,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.system}.default.overrideAttrs (old: {
      buildInputs =
        old.buildInputs
        ++ [
          pkgs.ffmpeg
        ];
    });
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = false;
      };
      auth = {
        fingerprint.enabled = true;
      };
      background = lib.mkForce [
        {
          monitor = "";
          path = "/home/moxie/wallpapers/hydrangeas-rain-hd.mp4";
        }
      ];
      input-field = {
        monitor = "";
        size = "600, 100";
        position = "0, 0";
        halign = "center";
        valign = "center";

        outline_thickness = 4;

        font_family = "Maple Mono NF CN";
        font_size = 32;

        placeholder_text = "Password...";
        fail_text = "Incorrect password";

        rounding = 0;
        shadow_passes = 0;
        fade_on_empty = false;
      };
      label = {
        monitor = "";
        text = "\$FPRINTPROMPT";
        text_align = "center";
        # color = "rgb(224, 222, 244)";
        font_size = 24;
        font_family = "Maple Mono NF CN";
        position = "0, -100";
        halign = "center";
        valign = "center";
      };
    };
  };
}
