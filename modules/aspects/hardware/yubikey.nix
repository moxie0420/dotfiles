{
  hardware.yubikey = {
    nixos = {pkgs, ...}: {
      # gpg my beloved
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      services = {
        # for the yubikeys smartcard mode
        pcscd.enable = true;

        udev.packages = builtins.attrValues {
          inherit (pkgs) yubikey-personalization;
        };
      };
    };
  };
}
