{lib, ...}: {
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  services = {
    hardware.openrgb.motherboard = "intel";
    xserver.videoDrivers = ["nvidia"];
  };

  powerManagement.cpuFreqGovernor = "performance";
  hardware.cpu.intel.updateMicrocode = true;
}
