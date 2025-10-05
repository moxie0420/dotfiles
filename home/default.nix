{...}: {
  imports = [
    ./hyprland
    ./programs
    ./scripts
    ./idle.nix
  ];

  home = {
    username = "moxie";
    homeDirectory = "/home/moxie";
    shell.enableShellIntegration = true;
    stateVersion = "23.11";
  };

  moxie = {
    audio.enable = true;
    shell = {
      enable = true;
      gpu = "nvidia";
    };
  };

  programs = {
    vesktop = {
      enable = true;
      settings = {
        discordBranch = "canary";
        tray = false;
        minimizeToTray = false;
        hardwareAcceleration = true;
        hardwareVideoAcceleration = true;
        arRPC = true;
        disableMinSize = true;
        enableSplashScreen = true;
      };
    };

    zen-browser = {
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      enableExtraSocket = true;
      sshKeys = [
        "C02F30F9FD65E05531A321C8491E3EFE1C0C7383"
      ];
    };

    mako = {
      enable = true;
      settings = {
        border-size = 2;
        border-radius = 16;
        anchor = "bottom-right";
        layer = "overlay";
        default-timeout = 5000;
        ignore-timeout = false;
        max-visible = 5;
        sort = "-time";
        group-by = "app-name";
        actions = true;
        format = "<b>%s</b>\\n%b";
        markup = true;
      };
    };

    udiskie = {
      enable = true;
      automount = true;
      tray = "never";
    };

    swww.enable = true;
  };

  stylix.targets.zen-browser.profileNames = [
    "default"
  ];

  xdg = {
    enable = true;
    autostart.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
