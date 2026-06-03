{
  den,
  lib,
  ...
}: {
  hardware.nvidia = {
    includes = [
      (den.provides.unfree ["nvidia-x11" "nvidia-settings"])
    ];

    # base nix config for Nvidia
    nixos = {
      environment.variables = {
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        GBM_BACKEND = "nvidia-drm";
        LIBVA_DRIVER_NAME = "nvidia";
        NVD_BACKEND = "direct";
        VDPAU_DRIVER = "nvidia";
        MOZ_DISABLE_RDD_SANDBOX = "1";
      };

      hardware.nvidia = {
        branch = "bleeding_edge";

        moduleParams.nvidia = {
          NVreg_UsePageAttributeTable = 1;
          NVreg_InitializeSystemMemoryAllocations = 0;
          NVreg_RegistryDwords = "EnableBrightnessControl=1";
        };

        open = true;

        powerManagement = {
          enable = true;
          finegrained = true;
        };
      };

      services.xserver.videoDrivers = ["nvidia"];
    };

    # prime for multi gpu
    prime.nixos = {config, ...}: {
      hardware.nvidia.prime = {
        offload = {
          enable = lib.mkOverride 990 true;
          enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true; # Provides `nvidia-offload` command.
        };
      };

      # Battery saver specilisation
      specialisation.battery-saver.configuration = {
        system.nixos.tags = ["battery-saver"];

        ##### disable nvidia, very nice battery life.
        boot.extraModprobeConfig = ''
          blacklist nouveau
          options nouveau modeset=0
        '';

        services.udev.extraRules = ''
          # Remove NVIDIA USB xHCI Host Controller devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

          # Remove NVIDIA USB Type-C UCSI devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

          # Remove NVIDIA Audio devices, if present
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

          # Remove NVIDIA VGA/3D controller devices
          ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
        '';
        boot.blacklistedKernelModules = [
          "nouveau"
          "nvidia"
          "nvidia_drm"
          "nvidia_modeset"
        ];

        hardware.nvidia = {
          prime.offload.enable = lib.mkForce false;
          powerManagement = {
            enable = lib.mkForce false;
            finegrained = lib.mkForce false;
          };
        };
      };
    };
  };
}
