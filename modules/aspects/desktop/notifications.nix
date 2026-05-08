{
  desktop.notifications.homeManager.services.mako = {
    enable = true;

    settings = {
      border-size = 2;
      border-radius = 16;
      anchor = "bottom-right";
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
