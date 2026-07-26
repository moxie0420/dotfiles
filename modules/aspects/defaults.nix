{
  lib,
  # aspects & namespaces
  den,
  programs,
  self,
  services,
  system,
  ...
}: {
  den = {
    # set some global static settings
    # mainly stateVersion
    default = {
      homeManager.home.stateVersion = "25.11";

      nixos = {
        home-manager = {
          backupFileExtension = "bak";
          useGlobalPkgs = true;
          useUserPackages = true;
        };

        security.pki.certificateFiles = ["${self}/benavides_CA.crt"];
        services.userborn.enable = true;
        system.stateVersion = "25.11";
        time.timeZone = "America/Chicago";
      };
    };

    default.includes = [
      den.batteries.mutual-provider
      den.batteries.hostname
      den.aspects.determinate
      den.aspects.nixpkgs

      # for formatting nix files
      programs.pedantix
      # ensure git is enabled and configured
      programs.git
      services.openssh
      system.boot
      system.boot.secure

      system.kernel.cachyos

      system.fonts
      system.lib'
      system.network
      system.nix
      system.power
      system.security
      system.shell
      system.shell.aliases
      system.shell.eza
      system.shell.zoxide

      system.systemd
      system.udev
      system.usb
    ];

    schema = {
      user = {
        # enable hm by default
        classes = lib.mkDefault ["homeManager"];

        # host<->user provides
        includes = [
          programs.ssh

          system.shell
          system.shell.aliases
          system.shell.eza
          system.shell.zoxide
        ];
      };
    };
  };
}
