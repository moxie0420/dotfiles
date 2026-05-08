{
  desktop.audio.nixos = {pkgs, ...}: {
    # Enable sound with pipewire.
    security.rtkit.enable = true;
    services.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable some useful pipewire tools.
    environment.systemPackages = with pkgs; [
      crosspipe
      playerctl
      pwvucontrol
    ];
  };
}
