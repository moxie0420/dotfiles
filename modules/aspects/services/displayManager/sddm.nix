{
  services.displayManager.sddm = {
    nixos = {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
