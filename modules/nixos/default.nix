inputs: let
  nixosModules = {
    audioModule = import ./audio.nix;
    desktopModule = import ./desktop.nix;
    developmentModule = import ./development.nix;
    displayManagerModule = import ./displaymanger.nix;
    graphicsModule = import ./graphics.nix;
    hardwareModule = import ./hardware.nix;
    overlayModule = import ../common/overlay.nix {flakes = inputs;};
    networkModule = import ./network.nix;
    nixConfigModule = import ./nix.nix;
    shellModule = import ./shell.nix;
    yubikeyModule = import ./yubikey.nix;
  };

  default = {self, ...}: {
    imports = builtins.attrValues nixosModules;

    home-manager.sharedModules = [
      self.homeModules.default
    ];
  };
in
  nixosModules // {inherit default;}
