{
  inputs,
  lib,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe inputs.hyprland.packages.${pkgs.system}.default}";
        user = "moxie";
      };
      initial_session = {
        command = "${lib.getExe inputs.hyprland.packages.${pkgs.system}.default}";
        user = "moxie";
      };
    };
  };

  security.pam.services.greetd.enableGnomeKeyring = true;
}
