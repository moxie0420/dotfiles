{
  lib,
  # deadnix: skip
  __findFile,
  ...
}: {
  # set some global static settings
  # mainly stateVersion
  den.default = {
    nixos = {
      home-manager.backupFileExtension = "bak";

      time.timeZone = "America/Chicago";

      system.stateVersion = "25.11";
    };
    homeManager.home.stateVersion = "25.11";
  };

  den.default.includes = [
    # ${user}.provides.${host} and ${host}.provides.${user}
    <den/mutual-provider>
    # Automatically set hostname
    <den/hostname>
    # Automatically create users on host.
    <den/define-user>

    # include editor & dev tools
    <dev-tools>
    <editor>
    # ensure git is enabled and configured
    <git>
    <secrets>
    <openssh>
    # ensure consistent theming
    <theme>

    <system/boot>
    <system/boot/graphical>
    <system/boot/secure>

    <system/fonts>
    <system/network>
    <system/nix>
    <system/power>
    <system/security>
    <system/shell>
    <system/shell/aliases>
    <system/shell/eza>
    <system/shell/zoxide>

    <system/systemd>
    <system/udev>
    <system/usb>

    <programs/flatpak>
  ];

  # enable hm by default
  den.schema.user.classes = lib.mkDefault ["homeManager"];

  # host<->user provides
  den.ctx.user.includes = [
    # include editor & dev tools
    <dev-tools>
    <editor>
    # ensure git is enabled and configured
    <git>
    # enable ssh client config
    <ssh>

    # ensure consistent theming
    <theme>

    <system/nix>
    <system/shell>
    <system/shell/aliases>
    <system/shell/eza>
    <system/shell/zoxide>
  ];
}
