{lib, ...}: {
  programs.btop = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) btop;
      };
    };
    homeManager.programs.btop = {
      enable = true;
      # TODO config btop
      settings = lib.mkAfter {
        theme_background = false;
      };
    };
  };
}
