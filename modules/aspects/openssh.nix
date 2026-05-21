{
  den.aspects.openssh = {
    nixos = {
      # Enable openssh
      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
          PermitRootLogin = "no";
        };
      };

      # Enable tailscale ssh
      services.tailscale.extraUpFlags = ["--ssh"];

      # enable Fail2Ban
      services.fail2ban.enable = true;
    };

    provides.to-users = {user, ...}: {
      nixos.services.openssh.settings.AllowUsers = [user.userName];
    };
  };
}
