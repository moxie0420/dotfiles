{
  pkgs,
  inputs,
  ...
}: let
  rosePine = {
    base = "#191724";
    surface = "#1f1d2e";
    overlay = "#26233a";
    muted = "#6e6a86";
    subtle = "#908caa";
    text = "#e0def4";
    love = "#eb6f92";
    gold = "#f6c177";
    rose = "#ebbcba";
    pine = "#31748f";
    foam = "#9ccfd8";
    iris = "#c4a7e7";
    highlightLow = "#21202e";
    highlightMed = "#403d52";
    highlightHigh = "#524f67";
  };
in {
  programs.ashell = {
    enable = true;
    package = inputs.ashell.defaultPackage.${pkgs.system};

    systemd.enable = true;

    settings = {
      modules = {
        left = ["Workspaces"];
        center = ["MediaPlayer"];
        right = ["SystemInfo" ["Clock" "Privacy" "Settings" "Tray"]];
      };

      workspaces = {
        visibility_mode = "MonitorSpecific";
        enable_workspace_filling = false;
      };

      apperance = {
        font = "Maple Mono NF CN";
        success_color = rosePine.pine;
        text_color = rosePine.text;

        workspace_colors = [rosePine.love rosePine.iris rosePine.rose];

        primary_color = rosePine.rose;

        secondary_color = rosePine.pine;

        danger_color = rosePine.love;

        background_color = {
          inherit (rosePine) base;
          weak = rosePine.overlay;
          strong = rosePine.surface;
        };
      };

      settings = {
        lock_cmd = "loginctl lock-session";
        remove_airplane_btn = true;
      };

      system = let
        warn_threshold = 75;
        alert_threshold = 90;
      in {
        indicators = ["Cpu" "Memory" "DownloadSpeed" "UploadSpeed"];

        cpu = {
          inherit warn_threshold alert_threshold;
        };

        memory = {
          inherit warn_threshold alert_threshold;
        };

        disk = {
          inherit warn_threshold alert_threshold;
        };

        tempurature = {
          inherit warn_threshold alert_threshold;
        };

        clock = {
          format = "%a %d %b %H:%M:%S";
        };
      };
    };
  };
}
