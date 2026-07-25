{
  desktop.dconf.nixos = {pkgs, ...}: let
    setDconfAttr = path: name: value: {
      settings.${path}.${name} = value;
    };

    setDefaultTerminal = path: setDconfAttr "org/cinnamon/desktop/default-applications/terminal" "exec" path;
  in {
    programs.dconf = {
      enable = true;
      profiles = {
        user.databases = [
          (setDefaultTerminal "${pkgs.kitty}/bin/kitty")
        ];
      };
    };
  };
}
