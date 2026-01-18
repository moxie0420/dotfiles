{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.moxie.graphics;
in {
  options.moxie.graphics = {
    amd = {
      enable = mkEnableOption "Enable AMD Support";
    };
    nvidia = {
      enable = mkEnableOption "Enable Nvidia Support";
    };
  };

  config = mkMerge [
    (mkIf cfg.amd.enable {
      hardware.amdgpu = {
        initrd.enable = true;
        opencl.enable = true;
      };

      services.xserver.videoDrivers = ["amdgpu"];
    })

    (mkIf cfg.nvidia.enable {
      environment.variables = {
        __GL_MaxFramesAllowed = 1;
        __GL_VRR_ALLOWED = 1;
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";

        GBM_BACKEND = "nvidia-drm";
        LIBVA_DRIVER_NAME = "nvidia";
        NVD_BACKEND = "direct";
        VDPAU_DRIVER = "nvidia";

        PROTON_ENABLE_NGX_UPDATER = 1;
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
