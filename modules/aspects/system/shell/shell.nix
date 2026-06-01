{lib, ...}: {
  system.shell = {
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

    homeManager = {pkgs, ...}: {
      home.packages = builtins.attrValues {
        inherit (pkgs) peazip;
      };
      programs.fish.shellInit = lib.mkBefore ''
        set fish_greeting
      '';
    };
  };
}
