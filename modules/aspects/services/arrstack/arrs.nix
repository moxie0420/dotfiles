{
  den,
  services,
  ...
}: {
  services.arrstack.containerized = {
    includes = [
      den.aspects.containers
    ];

    nixos = {
      networking.nat = {
        enable = true;
        # Lazy IPv6 connectivity for the container
        enableIPv6 = true;
        externalInterface = "eno2";
        internalInterfaces = ["ve-+"];
      };
    };

    # Primary Arrs
    starrs = {
      includes = [services.arrstack.containerized];
      nixos.containers.starrs = {
        config = {lib, ...}: {
          services = lib.mkMerge [
            (
              lib.genAttrs
              [
                "lidarr"
                "radarr"
                "readarr"
                "sonarr"
              ]
              (_: {
                enable = true;
                group = "nixarr";
                openFirewall = true;
              })
            )
          ];
          # ensure the nixarr group exists in the container
          users.groups.nixarr = {};
        };
        autoStart = true;
        hostAddress = "192.168.100.1";
        localAddress = "192.168.100.3";
        privateNetwork = true;
      };
    };
  };
}
