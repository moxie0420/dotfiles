{inputs, ...}: {
  services.pixiecore = let
    build = pxeSys.config.system.build;
    pxeSys = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ({
          config,
          modulesPath,
          ...
        }: {
          imports = [(modulesPath + "/installer/netboot/netboot-minimal.nix")];
          netboot.squashfsCompression = "zstd -Xcompression-level 6";

          services.openssh = {
            enable = true;
            openFirewall = true;

            settings = {
              KbdInteractiveAuthentication = false;
              PasswordAuthentication = false;
            };
          };

          system.stateVersion = config.system.nixos.release;

          users.users.root.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMPsHKCQ0mZQ+pCRlvVYh9MtqSnZJwhyhMktJbz3Axf5 Moxie@MoxieGE.com"
          ];
        })
      ];

      system = "x86_64-linux";
    };
  in {
    nixos = {
      services.pixiecore = {
        cmdLine = "init=${build.toplevel}/init loglevel=4";
        debug = true;
        dhcpNoBind = true;
        enable = true;
        initrd = "${build.netbootRamdisk}/initrd";
        kernel = "${build.kernel}/bzImage";
        mode = "boot";
        openFirewall = true;
        port = 6969;
      };
    };
  };
}
