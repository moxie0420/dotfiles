{
  den.aspects.autologin = {
    nixos = {user,...}: {
      autoLogin.user = user.name;
    };
  };
}
