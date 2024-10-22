{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    ./security.nix
    ./users.nix
    ./nix-ld.nix
  ];

  environment = {
    pathsToLink = ["share/thumbnailers"];
    systemPackages = with pkgs; [
      libheif
      libheif.out
      grim
      slurp
      wl-clipboard
      vesktop
      nixd
      inputs.zen-browser.packages."${system}".generic
      (pkgs.catppuccin-sddm.override
        {
          flavor = "mocha";
          font = "Noto Sans";
          fontSize = "9";
        })
    ];
  };

  services = {
    printing.enable = true;

    tumbler.enable = true;
    thermald.enable = true;
    flatpak.enable = true;
    fstrim.enable = true;
    dbus.packages = with pkgs; [dconf];

    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    displayManager.sddm = {
      enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
      wayland.enable = true;
    };
    hardware.openrgb = {
      enable = true;
      motherboard =
        if config.networking.hostName == "nixOwO"
        then "amd"
        else "intel";
      package = pkgs.openrgb-with-all-plugins;
    };
  };
  programs = {
    adb.enable = true;
    hyprland.enable = true;
    dconf.enable = true;
    gnome-disks.enable = true;
    file-roller.enable = true;
    ns-usbloader.enable = true;
    git.enable = true;
    htop.enable = true;
    direnv.enable = true;
  };
  environment = {
    sessionVariables = {
      QT_QPA_PLATFORM = "wayland;xcb";
      ANKI_WAYLAND = 1;
      NIXOS_OZONE_WL = 1;
      _JAVA_AWT_WM_NONEREPARENTING = 1;
      GDK_BACKEND = "wayland,x11";
      QT_AUTO_SCREEN_SCALE_FACTOR = 1;
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      MOZ_ENABLE_WAYLAND = 1;
      XDG_SESSION_TYPE = "wayland";
      CLUTTER_BACKEND = "wayland";
    };
  };
}
