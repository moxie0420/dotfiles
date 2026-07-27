{
  lib,
  den,
  inputs,
  self,
  withSystem,
  ...
}: {
  den.aspects.nixpkgs = {
    homeManager = {home, ...}: {
      nixpkgs.pkgs = withSystem home.system ({pkgs, ...}: pkgs);
    };

    nixos = {host, ...}: {
      nixpkgs.pkgs = withSystem host.system ({pkgs, ...}: pkgs);
    };

    provides.to-users.includes = [den.aspects.nixpkgs];
  };

  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;

      config = {
        allowUnfreePredicate = pkg:
          builtins.elem (lib.getName pkg) [
            "steam"
            "steam-original"
            "steam-unwrapped"
            "steam-run"
            "nvidia-x11"
            "nvidia-settings"
          ];
      };

      overlays = [
        self.overlays.default
        self.overlays.prismlauncher

        inputs.agenix.overlays.default
        inputs.niri.overlays.niri
        inputs.nix-cachyos-kernel.overlays.pinned
        inputs.nix-gaming-edge.overlays.proton-cachyos
        inputs.pedantix.overlays.default
      ];
    };
  };
}
