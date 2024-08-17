{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./desktop
    ./polkit.nix
    ./style.nix
    ./hardware
    ./harden.nix
  ];
  environment = {
    systemPackages = with pkgs; [
      sbctl
      brightnessctl
    ];
  };
  documentation = {
    enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
    dev.enable = true;
  };
  programs.adb.enable = true;
  users.users.moxie = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "pipewire"
      "plugdev"
      "wireshark"
      "adbusers"
      "docker"
    ];
    shell = pkgs.nushell;
  };

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
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

  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      allowed-users = [
        "moxie"
        "@wheel"
      ];
      trusted-users = [
        "moxie"
      ];
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "01:00";
    };
  };
}
