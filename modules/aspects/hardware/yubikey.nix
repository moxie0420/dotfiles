{
  hardware.yubikey = {
    nixos = {pkgs, ...}: {
      # gpg my beloved
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
      # for the yubikeys smartcard mode
      services.pcscd.enable = true;
      services.udev.packages = builtins.attrValues {
        inherit (pkgs) yubikey-personalization;
      };
    };
  };
}
