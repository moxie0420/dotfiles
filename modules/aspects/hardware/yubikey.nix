{
  hardware.yubikey = {
    nixos = {pkgs, ...}: {
      services.udev.packages = builtins.attrValues {
        inherit (pkgs) yubikey-personalization;
      };

      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}
