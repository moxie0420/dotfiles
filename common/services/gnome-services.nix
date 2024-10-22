{pkgs, ...}: {
  environment = {
    pathsToLink = ["share/thumbnailers"];
    systemPackages = with pkgs; [
      libheif
      libheif.out
    ];
  };
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
    };
    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];

    gnome.gnome-keyring.enable = true;

    gvfs.enable = true;
  };
}
