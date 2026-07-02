{
  services.ananicy = {
    nixos = {pkgs, ...}: {
      services.ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider = pkgs.ananicy-rules-cachyos;
      };
    };

    gamescopeRules.nixos = {
      services.ananicy.extraRules = [
        {
          name = "gamescope";
          nice = -20;
        }
      ];
    };
  };
}
