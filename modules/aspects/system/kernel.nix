{inputs, ...}: {
  flake-file.inputs.nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

  system.kernel = {
    cachyos.nixos = {pkgs, ...}: {
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

      nixpkgs.overlays = [
        inputs.nix-cachyos-kernel.overlays.pinned
      ];
    };
  };
}
