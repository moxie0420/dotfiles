{
  lib,
  # aspects & namespaces
  den,
  programs,
  system,
  ...
}: {
  # set some global static settings
  # mainly stateVersion
  den.default = {
    nixos = {
      home-manager = {
        backupFileExtension = "bak";
        useGlobalPkgs = true;
      };

      time.timeZone = "America/Chicago";

      system.stateVersion = "25.11";
    };
    homeManager.home.stateVersion = "25.11";
  };

  den.default.includes = [
    # ${user}.provides.${host} and ${host}.provides.${user}
    den._.mutual-provider
    # Automatically set hostname
    den._.hostname
    # Automatically create users on host.
    den._.define-user

    # allow for inputs'
    den.batteries.inputs'

    # include editor & dev tools
    den.aspects.dev-tools
    den.aspects.editor
    # ensure git is enabled and configured
    den.aspects.git
    den.aspects.secrets
    den.aspects.openssh
    # ensure consistent theming
    den.aspects.stylix

    system.boot
    system.boot.graphical
    system.boot.secure

    # system.kernel.cachyos
    system.kernel.cachyos.substituter

    system.fonts
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

    programs.flatpak
  ];

  # enable hm by default
  den.schema.user.classes = lib.mkDefault ["homeManager" "maid"];

  # host<->user provides
  den.schema.user.includes = [
    # include editor & dev tools
    den.aspects.dev-tools
    den.aspects.editor
    # ensure git is enabled and configured
    den.aspects.git
    # enable ssh client config
    den.aspects.ssh
    # ensure consistent theming
    den.aspects.stylix

    system.nix
    system.shell
    system.shell.aliases
    system.shell.eza
    system.shell.zoxide
  ];
}
