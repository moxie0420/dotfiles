{
  services.openssh = {
    nixos = {
      # enable Fail2Ban
      services.fail2ban.enable = true;
      # Enable openssh
      services.openssh = {
        enable = true;
        settings = {
          KbdInteractiveAuthentication = false;
          PasswordAuthentication = false;
          PermitRootLogin = "yes";
        };
      };
    };

    provides.to-users = {user, ...}: {
      nixos.services.openssh.settings.AllowUsers = [user.userName];
    };
  };
}
