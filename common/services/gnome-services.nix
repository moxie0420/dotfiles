{pkgs, ...}: {
  services = {
    xserver.displayManager.gdm.enable = true;
    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];

    gnome.gnome-keyring.enable = true;

    gvfs.enable = true;

    environment = {
      pathsToLink = ["share/thumbnailers"];
      systemPackages = with pkgs; [
        libheif
        libheif.out
      ];
    };
  };
}
