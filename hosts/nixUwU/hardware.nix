{
  config,
  lib,
  ...
}: {
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "performance";
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    enableAllFirmware = true;

    display = {
      edid.linuxhw = {
        ROG_PG27U = ["PG27U" "2018"];
      };
      outputs = {
        "DP-1" = {
          edid = "ROG_PG27U.bin";
          mode = "D";
        };
      };
    };

    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = false;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    opentabletdriver.enable = true;
    ckb-next.enable = true;
  };
}
