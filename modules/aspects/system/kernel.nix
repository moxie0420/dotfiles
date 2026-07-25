{system, ...}: {
  flake-file.inputs.nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

  system.kernel = {
    cachyos = {
      includes = [
        system.kernel.cachyos.substituter
      ];
      nixos = {pkgs, ...}: {
        boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
      };
      substituter.nixos.nix.settings = {
        substituters = ["https://attic.xuyh0120.win/lantian"];
        trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];
      };
    };
  };
}
