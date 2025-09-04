{pkgs, ...}: let
  change-ws = pkgs.writeScriptBin "change-ws.nu" ''
    #!/usr/bin/env nu
    def main [direction: string,current: int] {
      mut target = 0;
      if $direction == "up" {
        $target = $current + 1
      } else if $direction == "down" {
        $target = $current - 1
      }
      if $target > 0 and $target < 11 {
        hyprctl dispatch workspace $target
      }
    }
  '';
in {
  home.packages = [change-ws];
}
