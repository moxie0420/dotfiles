{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    dive
    docker-compose
    lazydocker
  ];

  virtualisation = {
    containers.enable = true;
    oci-containers.backend = "docker";
    docker.enable = true;
    # podman = {
    #   enable = true;
    #   dockerCompat = true;
    #   dockerSocket.enable = true;
    #   defaultNetwork.settings.dns_enabled = false;
    # };
  };
}
