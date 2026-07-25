{
  desktop.audio.nixos = {pkgs, ...}: {
    # Enable some useful pipewire tools.
    environment.systemPackages = with pkgs; [
      crosspipe
      playerctl
      pwvucontrol
    ];
    # Enable sound with pipewire.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    services.pulseaudio.enable = false;
  };
}
