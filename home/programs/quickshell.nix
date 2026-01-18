{
  inputs,
  pkgs,
  ...
}: {
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
