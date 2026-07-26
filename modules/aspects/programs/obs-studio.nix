{
  programs = {
    gpu-screen-recorder = {
      nixos = {pkgs, ...}: {
        environment.systemPackages = [pkgs.gpu-screen-recorder];
      };
    };

    obs-studio = {
      nixos = {pkgs, ...}: {
        programs.obs-studio = {
          enable = true;
          enableVirtualCamera = true;

          plugins = builtins.attrValues {
            inherit
              (pkgs.obs-studio-plugins)
              wlrobs
              obs-backgroundremoval
              obs-gstreamer
              obs-vkcapture
              ;
          };
        };
      };
    };
  };
}
