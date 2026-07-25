{services, ...}: {
  services.arrstack.tdarr = {
    containerized.nixos = {
      containers.webserver = {
        config = services.arrstack.bazarr.nixos;
        autoStart = true;
        hostAddress = "192.168.100.1";
        hostAddress6 = "fc00::1";
        localAddress = "192.168.100.4";
        localAddress6 = "fc00::10";
        privateNetwork = true;
      };
    };

    nixos = {config, ...}: {
      services.tdarr = {
        enable = true;
        group = "nixarr";
        openFirewall = config.boot.isContainer;
      };
    };
  };
}
