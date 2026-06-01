{den, ...}: {
  # user aspect
  den.aspects.madeline = {
    includes = [
      den.provides.primary-user
      (den.provides.user-shell "fish")
    ];

    homeManager = {pkgs, ...}: {
      home.packages = builtins.attrValues {
        inherit
          (pkgs)
          cyanrip
          element-desktop
          ;
      };
    };

    # user can provide NixOS configurations
    # to any host it is included on
    provides.to-hosts = {user, ...}: {
      nixos.users.users.${user.userName}.description = "Madeline P. Benavides";
    };
  };
}
