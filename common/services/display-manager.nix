{
  inputs,
  pkgs,
  ...
}: {
  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
    };
    sessionPackages = [
      inputs.hyprland.packages.${pkgs.system}.default
    ];
  };
}
