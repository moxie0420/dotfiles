{ config, pkgs, lib, ... }:
{
    programs.thunderbird = {
        enable = true;

        profiles = {
            moxie = {
                isDefault = true;
                withExternalGnupg = true;
            };
        }
    };
}