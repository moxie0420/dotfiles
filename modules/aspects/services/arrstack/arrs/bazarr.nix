{services, ...}: {
  services.arrstack.bazarr = {
    containerized.nixos = {
      containers.webserver = {
        autoStart = true;
        config = services.arrstack.bazarr.nixos;
        hostAddress = "192.168.100.1";
        hostAddress6 = "fc00::1";
        localAddress = "192.168.100.10";
        localAddress6 = "fc00::10";
        privateNetwork = true;
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
