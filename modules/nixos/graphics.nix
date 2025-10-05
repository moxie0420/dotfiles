{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.moxie.graphics;
in {
  options.moxie.graphics = {
    enable = mkEnableOption "Enable my graphics config";
    amd = {
      enable = mkEnableOption "Enable AMD Support";
    };
    nvidia = {
      enable = mkEnableOption "Enable Nvidia Support";
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    })

    (mkIf cfg.amd.enable {
      moxie.graphics.enable = true;

      hardware.amdgpu = {
        initrd.enable = true;
        opencl.enable = true;
      };

      services.xserver.videoDrivers = ["amdgpu"];
    })

    (mkIf cfg.nvidia.enable {
      moxie.graphics.enable = true;

      environment.variables = {
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        GBM_BACKEND = "nvidia-drm";
        LIBVA_DRIVER_NAME = "nvidia";
        VDPAU_DRIVER = "nvidia";
        NVD_BACKEND = "direct";
      };

      boot.extraModprobeConfig = ''
        options nvidia NVreg_UsePageAttributeTable=1 \
          NVreg_InitializeSystemMemoryAllocations=0 \
          NVreg_DynamicPowerManagement=0x02 \
          NVreg_PreserveVideoMemoryAllocations=1
      '';

      hardware.nvidia = {
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        videoAcceleration = true;
      };

      services.xserver.videoDrivers = ["nvidia"];
    })
  ];
}
