{
  services.displayManager.autoLogin = {
    nixos = {user, ...}: {
      services.displayManager.autoLogin = {
        enable = true;
        user = user.name;
      };
    };
  };
}
