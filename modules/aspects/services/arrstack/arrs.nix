{
  den,
  services,
  ...
}: {
  services.arrstack.containerized = let
    hostAddress = "192.168.100.10";
    hostAddress6 = "fc00::1";
  in {
    includes = [
      den.aspects.containers
    ];

    nixos = {
      networking.nat = {
        enable = true;
        internalInterfaces = ["ve-+"];
        externalInterface = "eno2";
        # Lazy IPv6 connectivity for the container
        enableIPv6 = true;
      };
    };

    # Primary Arrs
    starrs = {
      includes = [services.arrstack.containerized];
      nixos.containers.starrs = {
        autoStart = true;
        privateNetwork = true;

        inherit hostAddress hostAddress6;

        localAddress = "192.168.100.11";
        localAddress6 = "fc00::2";

        config = {lib, ...}: {
          # ensure the nixarr group exists in the container
          users.groups.nixarr = {};

          services = lib.mkMerge [
            (lib.genAttrs
              [
                "lidarr"
                "radarr"
                "readarr"
                "sonarr"
              ]
              (_: {
                enable = true;
                openFirewall = true;
                group = "nixarr";
              }))
          ];
        };
      };
    };
  };
}
