{
  den.aspects.nixUwU.network = {host, ...}: {
    nixos = {
      systemd.network = {
        networks = {
          "10-lan" = {
            address = [
              host.address
              host.addressV6
            ];

            linkConfig.RequiredForOnline = "routable";
            matchConfig.name = "eno2";

            routes = [
              {Gateway = "192.168.50.1";}
            ];
          };
        };

        wait-online.enable = false;
      };
    };
  };
}
