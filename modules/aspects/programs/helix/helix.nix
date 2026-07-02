{programs, ...}: {
  programs.helix = {
    includes = [
      programs.helix.formatters
      programs.helix.languages
      programs.helix.settings
    ];

    homeManager.programs.helix = {
      enable = true;
      defaultEditor = true;
    };
  };

  nixos = {pkgs, ...}: {
    environment = {
      systemPackages = builtins.attrValues {
        inherit (pkgs) helix;
      };
      variables.EDITOR = "hx";
    };
  };
}
