{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./desktop
    ./polkit.nix
    ./hardware
    ./harden.nix
  ];

  console = {
    enable = false;
    earlySetup = false;
    keyMap = lib.mkDefault "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };
}
