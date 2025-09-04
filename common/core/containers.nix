{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.docker-compose
  ];

  virtualisation = {
    containers.enable = true;
    docker.enable = true;
  };
}
