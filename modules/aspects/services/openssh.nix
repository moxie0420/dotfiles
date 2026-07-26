{
  services.openssh = {
    nixos = {
      services = {
        # enable Fail2Ban
        fail2ban.enable = true;

        # Enable openssh
        openssh = {
          enable = true;

          settings = {
            KbdInteractiveAuthentication = false;
            PasswordAuthentication = false;
            PermitRootLogin = "yes";
          };
        };
      };
    };

    provides.to-users = {user, ...}: {
      nixos.services.openssh.settings.AllowUsers = [user.userName];
    };
  };
}
