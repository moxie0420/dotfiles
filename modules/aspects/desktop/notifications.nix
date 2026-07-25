{
  desktop.notifications.homeManager.services.mako = {
    enable = true;

    settings = {
      actions = true;
      anchor = "bottom-right";
      border-radius = 16;
      border-size = 2;
      default-timeout = 5000;
      format = "<b>%s</b>\\n%b";
      group-by = "app-name";
      ignore-timeout = false;
      layer = "overlay";
      markup = true;
      max-visible = 5;
      sort = "-time";
    };
  };
}
