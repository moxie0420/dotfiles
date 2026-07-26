{lib, ...}: {
  hardware.nvidia = {
    # base nix config for Nvidia
    nixos = {
      hardware.nvidia = {
        branch = "bleeding_edge";
        moduleParams.nvidia.NVreg_RegistryDwords = "EnableBrightnessControl=1";
        open = true;
        powerManagement.enable = true;
      };

      services.xserver.videoDrivers = ["nvidia"];
    };

    # prime for multi gpu
    prime.nixos = {config, ...}: {
      hardware.nvidia = {
        powerManagement.finegrained = true;

        prime.offload = {
          enable = lib.mkOverride 990 true;
          enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true; # Provides `nvidia-offload` command.
        };
      };

      # Battery saver specilisation
      specialisation.battery-saver.configuration = {
        boot = {
          blacklistedKernelModules = [
            "nouveau"
            "nvidia"
            "nvidia_drm"
            "nvidia_modeset"
          ];

          ##### disable nvidia, very nice battery life.
          extraModprobeConfig = ''
            blacklist nouveau
            options nouveau modeset=0
          '';
        };

        hardware.nvidia = {
          powerManagement = {
            enable = lib.mkForce false;
            finegrained = lib.mkForce false;
          };

          prime.offload.enable = lib.mkForce false;
        };

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

        system.nixos.tags = ["battery-saver"];
      };
    };
  };
}
