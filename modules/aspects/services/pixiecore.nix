{inputs, ...}: {
  services.pixiecore = let
    pxeSys = inputs.nixos.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({modulesPath, ...}: {
          imports = [(modulesPath + "/installer/netboot/netboot-minimal.nix")];

          services.openssh = {
            enable = true;
            openFirewall = true;

            settings = {
              PasswordAuthentication = false;
              KbdInteractiveAuthentication = false;
            };
          };

          users.users.root.openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMPsHKCQ0mZQ+pCRlvVYh9MtqSnZJwhyhMktJbz3Axf5 Moxie@MoxieGE.com"
          ];
        })
      ];
    };

    build = pxeSys.config.system.buildl;
  in {
    nixos = {
      services.pixiecore = {
        enable = true;
        openFirewall = true;
        dhcpNBind = true;

        mode = "boot";
        kernel = "${build.kernel}/bzImage";
        initrd = "${build.netbootRamdisk}/initrd";
        cmdLine = "init=${build.toplevel}/init loglevel=4";
        debug = true;
      };
    };
  };
}
