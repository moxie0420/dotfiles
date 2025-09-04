{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pamixer
    playerctl
    pavucontrol
  ];

  security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
