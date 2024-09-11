{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./desktop
    ./polkit.nix
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

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
    libraries = with pkgs; [
      alsa-lib
      at-spi2-atk
      at-spi2-core
      atk
      cairo
      cups
      curl
      dbus
      expat
      fontconfig
      freetype
      fuse3
      gdk-pixbuf
      glib
      gtk3
      icu
      libGL
      libappindicator-gtk3
      libdrm
      libglvnd
      libnotify
      libpulseaudio
      libunwind
      libusb1
      libuuid
      libxkbcommon
      libxml2
      mesa
      nspr
      nss
      openssl
      pango
      pipewire
      stdenv.cc.cc
      systemd
      vlc
      vulkan-loader
      xorg.libX11
      xorg.libXScrnSaver
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXtst
      xorg.libxcb
      xorg.libxkbfile
      xorg.libxshmfence
      zlib
    ];
  };

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
