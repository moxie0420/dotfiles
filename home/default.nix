{
  config,
  inputs,
  pkgs,
  ...
}: {
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

    packages = with pkgs; let
      inherit (inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}) awww;
    in [
      awww
      kdePackages.filelight
      lxqt.lxqt-policykit
    ];
  };

  moxie = {
    enable = true;
    audio.enable = true;
    shell = {
      enable = true;
      gpu = "nvidia";
    };
    communication.vesktop = false;
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

    tldr-update.enable = true;
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

    configFile = let
      inherit (config.lib.file) mkOutOfStoreSymlink;
      inherit (config) dotfiles;

      toSrcFile = name: "${dotfiles}/${name}";
      link = name: mkOutOfStoreSymlink (toSrcFile name);

      # linkFile = name: {
      #   ${name}.source = link name;
      # };

      linkDir = name: {
        ${name} = {
          source = link name;
          recursive = true;
        };
      };

      confFiles = {};

      confDirs = linkDir "quickshell";

      links = confFiles // confDirs;
    in
      links;
  };
}
