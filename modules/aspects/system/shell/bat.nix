{
  system.shell.bat = {
    homeManager = {
      home.sessionVariables = {
        MANPAGER = "sh -c 'col -bx | bat --plain --language man'";
        MANROFFOPT = "-c";
      };
      programs.bat = {
        config = {
          color = "auto";
          decorations = "auto";
          italic-text = "always";
          nonprintable-notation = "unicode";
          pager = "less";
          paging = "auto";
          style = "numbers,header";
          tabs = "2";
        };
        enable = true;
      };
    };
    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) bat;
      };
    };
  };
}
