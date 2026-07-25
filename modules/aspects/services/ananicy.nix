{
  services.ananicy = {
    gamescopeRules.nixos = {
      services.ananicy.extraRules = [
        {
          name = "gamescope";
          nice = -20;
        }
      ];
    };
    nixos = {pkgs, ...}: {
      services.ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider = pkgs.ananicy-rules-cachyos;
      };
    };
  };
}
