{
  inputs,
  pkgs,
  ...
}: {
  security.polkit.enable = true;
  systemd.user.services.hypr-polkit-agent = {
    description = "hypr-polkit-agent";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${inputs.hyprpolkitagent.packages.${pkgs.system}.default}/libexec/hyprpolkitagent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
