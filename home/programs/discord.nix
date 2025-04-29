{pkgs, ...}: {
  home.packages = [
    pkgs.vesktop
  ];

  wayland.windowManager.hyprland = {
    windowrulev2 = [
      "workspace 9, class:(legcord)"
      "workspace 9, class:(vesktop)"
    ];
  };
}
