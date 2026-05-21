{
  hardware.bluetooth = {
    nixos = {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;

        settings = {
          General = {
            Experimental = true;
            KernelExperimental = true;
            FastConnectable = true;
          };

          Policy = {
            AutoEnable = true;
          };
        };
      };
    };
  };
}
