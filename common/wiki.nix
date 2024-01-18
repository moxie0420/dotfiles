{ config, pkgs, lib, ... }:
{
    services.mediawiki = {
        enable = true;

        name = "Moxies brew";
        url = "https://brew.wiki";
    }
}