{den, ...}: {
  hardware.nvidia = {
    includes = [
      (den.provides.unfree ["nvidia-x11" "nvidia-settings"])
    ];
    nixos = {
      config,
      pkgs,
      ...
    }: {
      boot.extraModprobeConfig = ''
        options nvidia NVreg_UsePageAttributeTable=1 \
          NVreg_InitializeSystemMemoryAllocations=0 \
          NVreg_DynamicPowerManagement=0x02 \
          NVreg_PreserveVideoMemoryAllocations=1
      '';

      environment.variables = {
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        GBM_BACKEND = "nvidia-drm";
        LIBVA_DRIVER_NAME = "nvidia";
        NVD_BACKEND = "direct";
        VDPAU_DRIVER = "nvidia";
        MOZ_DISABLE_RDD_SANDBOX = "1";
      };

      hardware = {
        graphics.extraPackages = with pkgs; [nvidia-vaapi-driver];

        nvidia-container-toolkit.enable = true;

        nvidia = {
          open = true;
          package = config.boot.kernelPackages.nvidiaPackages.beta;
          videoAcceleration = true;
        };
      };

      services.xserver.videoDrivers = ["nvidia"];
    };
  };
}
