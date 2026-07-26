{lib, ...}: {
  system.shell = {
    homeManager = {pkgs, ...}: {
      home.packages = builtins.attrValues {
        inherit (pkgs) peazip;
      };

      programs.fish.shellInit = lib.mkBefore ''
        set fish_greeting
      '';
    };

    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) peazip;
      };

      programs.fish = {
        shellInit = lib.mkBefore ''
          set fish_greeting
        '';

        useBabelfish = true;
      };
    };
  };
}
