{
  config,
  lib,
  ...
}: let
  inherit (builtins) elem;
  inherit (lib) mkIf;

  cfg = config.services.xserver.videoDrivers;

  isNvidia = elem "nvidia" cfg;
  isAmd = elem "amdgpu" cfg;
in {
  config = {
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      nvidia = mkIf isNvidia {
        open = lib.mkForce true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        videoAcceleration = true;
      };

      amdgpu = mkIf isAmd {
        initrd.enable = true;
        opencl.enable = true;
      };
    };

    boot.extraModprobeConfig = mkIf isNvidia ''
      options nvidia NVreg_UsePageAttributeTable=1 \
        NVreg_InitializeSystemMemoryAllocations=0 \
        NVreg_DynamicPowerManagement=0x02
    '';
  };
}
