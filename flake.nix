{
  description = "Moxie's RPI3B nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: rec {
    nixosConfigurations.piTime = nixpkgs.lib.nixosSystem {
      modules = [
        "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
        {
          nixpkgs.config.allowUnsupportedSystem = true;
          nixpkgs.hostPlatform.system = "Aarch64-linux";
          nixpkgs.buildPlatform.system = "x86_64-linux"; #If you build on x86 other wise changes this.
          # ... extra configs as above
        }
        ./config.nix
      ];
    };
    images.piTime = nixosConfigurations.piTimeconfig.system.build.sdImage;
  };
}
