{inputs, ...}: {
  flake-file.inputs.nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

  system.kernel = {
    cachyos = {
      nix = {
        substituters = ["https://attic.xuyh0120.win/lantian"];
        trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];
      };
      nixos = {pkgs, ...}: {
        boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

        nixpkgs.overlays = [
          inputs.nix-cachyos-kernel.overlays.pinned
        ];
      };
    };
  };
}
