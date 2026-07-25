{
  hardware.bluetooth = {
    nixos = {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;

        settings = {
          General = {
            Experimental = true;
            FastConnectable = true;
            KernelExperimental = true;
          };

          Policy = {
            AutoEnable = true;
          };
        };
      };
    };
  };
}
