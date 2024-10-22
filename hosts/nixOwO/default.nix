# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./boot.nix
    ./disks.nix
    ./hardware.nix
    ./network.nix
    ../../common
  ];

  services = {
    udev.extraRules = ''
      ACTION=="remove",\
          			ENV{ID_BUS}=="usb",\
      	ENV{ID_MODEL_ID}=="0407",\
      	ENV{ID_VENDOR_ID}=="1050",\
      	ENV{ID_VENDOR}=="Yubico",\
      	RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"

      ACTION=="add",\
          			ENV{ID_BUS}=="usb",\
      	ENV{ID_MODEL_ID}=="0407",\
      	ENV{ID_VENDOR_ID}=="1050",\
      	ENV{ID_VENDOR}=="Yubico",\
      	RUN+="${pkgs.systemd}/bin/loginctl unlock-sessions"
    '';
  };
  system.stateVersion = "23.05";
}
