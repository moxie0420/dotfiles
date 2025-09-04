{
  pkgs,
  lib,
  ...
}: let
  wine = pkgs.wineWowPackages.staging;
  winepath = lib.getExe wine;
in {
  environment = {
    systemPackages = [
      wine
    ];
    sessionVariables.WINE_BIN = winepath;
  };

  boot = {
    binfmt.registrations."DOSWin" = {
      wrapInterpreterInShell = false;
      interpreter = winepath;
      recognitionType = "magic";
      offset = 0;
      magicOrExtension = "MZ";
    };
    kernelModules = ["ntsync"];
  };

  services.udev.packages = [
    (pkgs.writeTextFile {
      name = "ntsync-udev-rules";
      text = ''KERNEL=="ntsync", MODE="0660", TAG+="uaccess"'';
      destination = "/etc/udev/rules.d/70-ntsync.rules";
    })
  ];
}
