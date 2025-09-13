{...}: {
  imports = [
    ./audio.nix
    ./disks.nix
    ./hardware.nix
  ];

  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";
    NVD_BACKEND = "direct";
  };

  boot.blacklistedKernelModules = [
    "acpi_cpufreq"
  ];

  networking.hostName = "nixUwU";
}
