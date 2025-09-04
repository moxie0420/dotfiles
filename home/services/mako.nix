let
  rosePine = {
    base = "191724";
    surface = "1f1d2e";
    overlay = "26233a";
    muted = "6e6a86";
    subtle = "908caa";
    text = "e0def4";
    love = "eb6f92";
    gold = "f6c177";
    rose = "ebbcba";
    pine = "31748f";
    foam = "9ccfd8";
    iris = "c4a7e7";
    highlightLow = "21202e";
    highlightMed = "403d52";
    highlightHigh = "524f67";
  };
in {
  services.mako = {
    enable = true;

    settings = {
      background-color = "#${rosePine.overlay}";
      text-color = "#${rosePine.text}";
      border-color = "#${rosePine.pine}";
      progress-color = "#${rosePine.rose}";

      width = 420;
      height = 110;
      padding = 10;
      margin = 10;
      border-size = 2;
      border-radius = 16;

      anchor = "top-right";
      layer = "overlay";

      default-timeout = 5000;
      ignore-timeout = false;
      max-visible = 5;
      sort = "-time";

      group-by = "app-name";

      actions = true;

      format = "<b>%s</b>\\n%b";
      markup = true;
    };
  };
}
