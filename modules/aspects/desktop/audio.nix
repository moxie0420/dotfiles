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

    services = {
      pipewire = {
        alsa = {
          enable = true;
          support32Bit = true;
        };

        enable = true;
        pulse.enable = true;
      };

      pulseaudio.enable = false;
    };
  };
}
