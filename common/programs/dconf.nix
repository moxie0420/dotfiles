{
  programs.dconf = {
    enable = true;
    profiles.gdm.databases = [
      {
        settings = {
          "org/gnome/desktop/interface".cursor-theme = "rose-pine";
        };
      }
    ];
  };
}
