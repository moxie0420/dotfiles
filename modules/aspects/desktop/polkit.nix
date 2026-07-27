{
  desktop.polkit.nixos = {
    security.polkit = {
      # Ensure the wheel group is treated as admin
      adminIdentities = [
        "unix-group:wheel"
      ];

      enable = true;

      extraConfig = ''
        polkit.addRule(function (action, subject) {
          if (
            subject.isInGroup("users") &&
            [
              "org.freedesktop.login1.reboot",
              "org.freedesktop.login1.reboot-multiple-sessions",
              "org.freedesktop.login1.power-off",
              "org.freedesktop.login1.power-off-multiple-sessions",
            ].indexOf(action.id) !== -1
          ) return polkit.Result.YES;
        });
      '';
    };
  };
}
