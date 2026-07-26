{
  lib,
  inputs,
  self,
  withSystem,
  ...
}: {
  den.aspects.nixpkgs = {
    nixos = {host, ...}: {
      nixpkgs.pkgs = withSystem host.system ({pkgs, ...}: pkgs);
    };
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
        inputs.deploy-rs.overlays.default
        inputs.niri.overlays.niri
        inputs.nix-cachyos-kernel.overlays.pinned
        inputs.nix-gaming-edge.overlays.proton-cachyos
        inputs.pedantix.overlays.default

        (final: prev: {
          deploy-rs = {
            inherit (prev) deploy-rs;
            lib = final.deploy-rs.lib;
          };
        })
      ];
    };
  };
}
