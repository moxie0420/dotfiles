{services, ...}: {
  services.arrstack.bazarr = {
    containerized.nixos = {
      containers.webserver = {
        autoStart = true;
        privateNetwork = true;

        hostAddress = "192.168.100.1";
        localAddress = "192.168.100.10";

        hostAddress6 = "fc00::1";
        localAddress6 = "fc00::10";
        config = services.arrstack.bazarr.nixos;
      };
    };

    nixos = {config, ...}: {
      services.bazarr = {
        enable = true;
        group = "nixarr";
        openFirewall = config.boot.isContainer;
      };
    };
  };
}
