{
  config,
  inputs,
  lib,
  lib',
  pkgs,
  self,
  ...
}: {
  imports = [
    ./boot.nix
    ./console.nix
    ./containers.nix
    ./security.nix
    ./systemd.nix
    ./users.nix
  ];

  environment.systemPackages = with pkgs; [
    clipse
    pwvucontrol
  ];

  documentation.dev.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = lib.mkDefault "23.11";
  time.timeZone = lib.mkDefault "America/Chicago";

  sops = {
    defaultSopsFile = ../secrets.yaml;

    age = {
      sshKeyPaths = ["/home/moxie/.ssh/bitbucket_personal"];
      keyFile = "/home/moxie/.config/sops/age/keys.txt";
      generateKey = true;
    };

    secrets = {
      "lastfm-password" = {};
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.moxie = import ../home;
    extraSpecialArgs = {
      inherit inputs self lib';
      inherit (config.networking) hostName;
    };
    sharedModules = with inputs; [
      zen-browser.homeModules.twilight
    ];
  };

  moxie = {
    audio.enable = true;
    desktop.enable = true;

    development = {
      enable = true;
      name = "Moxie Benavides";
      email = "moxie@moxiege.com";
    };

    displayManager.enable = true;

    hardware = {
      enable = true;
      enableBluetooth = true;
      enableRGB = true;
      enableVR = true;
    };

    networking.enable = true;

    shell = {
      enable = true;
      enableShowoff = true;
    };
  };

  nix.nixPath = let
    path = toString ./.;
  in [
    "repl=${path}/repl.nix"
    "nixpkgs=${inputs.nixpkgs}"
  ];

  programs.nh.flake = "/home/moxie/dotfiles";

  services.mpdscribble.endpoints = {
    "last.fm" = {
      passwordFile = "/run/secrets/lastfm-password";
      username = "Eg42069";
    };
  };

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  };
}
