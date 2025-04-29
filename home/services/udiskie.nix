{pkgs, ...}: {
  services.udiskie = {
    enable = true;
    automount = true;
    tray = "never";
    settings = {
      program_options = {
        file_manager = "${pkgs.nautilus}/bin/nautilus";
      };
    };
  };
}
