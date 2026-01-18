{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    docker-compose
  ];

  virtualisation = {
    containers.enable = true;
    oci-containers.backend = "podman";
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
