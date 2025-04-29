{pkgs, ...}: {
  home.packages = [
    pkgs.vesktop
  ];

  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "workspace 9, class:(legcord)"
      "workspace 9, class:(vesktop)"
    ];
  };
}
