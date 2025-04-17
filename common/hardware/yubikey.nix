{pkgs, ...}: {
  services = {
    udev.packages = [pkgs.yubikey-personalization];
    pcscd.enable = true;
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableExtraSocket = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };

  services.udev.extraRules = ''
    ACTION=="remove",\
      ENV{ID_BUS}=="usb",\
    	ENV{ID_MODEL_ID}=="0407",\
    	ENV{ID_VENDOR_ID}=="1050",\
    	ENV{ID_VENDOR}=="Yubico",\
    	RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';
}
