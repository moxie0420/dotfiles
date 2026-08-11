let
  ezaAliases = let
    eza = "eza --group-directories-first";
  in {
    l = eza;
    la = "${eza} -a";
    ll = "${eza} -l --time-style=long-iso --header";
    ls = eza;
  };
in {
  system.shell.eza = {
    homeManager = {
      home.shellAliases = ezaAliases;

      programs.eza = {
        colors = "auto";
        enable = true;
        git = true;
        icons = "auto";
      };
    };

    nixos = {pkgs, ...}: {
      environment = {
        shellAliases = ezaAliases;

        systemPackages = builtins.attrValues {
          inherit (pkgs) eza;
        };
      };
    };
  };
}
