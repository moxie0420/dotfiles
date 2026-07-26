{
  den,
  programs,
  services,
  ...
}: {
  den.aspects.gaming = {
    extraLaunchers = {
      homeManager = {pkgs, ...}: {
        home.packages = builtins.attrValues {
          inherit
            (pkgs)
            deadlock-mod-manager
            heroic
            olympus
            prismlauncher
            r2modman
            ;
        };
      };

      nixos = {pkgs, ...}: {
        environment.systemPackages = builtins.attrValues {
          inherit
            (pkgs)
            deadlock-mod-manager
            heroic
            olympus
            prismlauncher
            r2modman
            ;
        };
      };

      provides = {
        to-hosts.includes = [den.aspects.gaming.extraLaunchers];
        to-users.includes = [den.aspects.gaming.extraLaunchers];
      };
    };

    homeManager = {
      home.sessionVariables = {
        PROTON_DXVK_LOWLATENCY = "1";
      };
    };

    includes = [
      programs.gamescope
      programs.steam

      services.ananicy
      services.ananicy.gamescopeRules
    ];

    provides = {
      to-hosts.includes = [den.aspects.gaming];
      to-users.includes = [den.aspects.gaming];
    };
  };
}
