{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    hyprpicker
    hyprshot
    hyprsunset
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    package = inputs.hyprland.packages.${pkgs.system}.default;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };
}
