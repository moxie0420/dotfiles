{ config, pkgs, ... }:
{
    imports = [
        ./boot.nix
        ./disks.nix
        ./hardware.nix
        ./network.nix
        ../../common
    ];
    system.stateVersion = "23.05";
}