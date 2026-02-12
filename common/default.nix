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
    ./containers.nix
    ./security.nix
    ./systemd.nix
    ./users.nix
  ];

  age = {
    identityPaths = ["/home/moxie/.ssh/bitbucket_personal"];
    secrets = {
      qbittorrent.file = "${self}/secrets/qbittorrent.age";
      homarr.file = "${self}/secrets/homarr.age";
    };
  };

  environment.systemPackages = with pkgs; [
    inputs.agenix.packages.x86_64-linux.default
    clipse
    gzdoom
    pwvucontrol
  ];

  documentation.dev.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "ibus";
    };
  };

  time.timeZone = lib.mkDefault "America/Chicago";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.moxie = import ../home;
    extraSpecialArgs = {
      inherit inputs self lib';
      inherit (config.networking) hostName;
    };
  };

  moxie = {
    audio.enable = true;
    desktop = {
      enable = true;
      gaming.gamescopeArgs = [
        "-W 1920"
        "-H 1080"
        "--expose-wayland"
        "--mangoapp"
      ];
    };

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

  services = {
    flatpak.enable = true;
    tailscale.extraSetFlags = [
      "--operator=moxie"
    ];
  };

  security.pki.certificateFiles = [
    ../secrets/rootCA.pem
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  };
}
