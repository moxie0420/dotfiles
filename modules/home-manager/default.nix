let
  homeModules = {
    audioModule = import ./audio.nix;
    shellModule = import ./shell.nix;
  };

  default = {...}: {
    imports = builtins.attrValues homeModules;
  };
in
  homeModules // {inherit default;}
