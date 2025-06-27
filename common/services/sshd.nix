{
  services = {
    fail2ban.enable = true;

    openssh = {
      enable = true;

      ports = [19788];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = ["moxie"];
        X11Forwarding = false;
        PermitRootLogin = "no";
      };
    };
  };
}
