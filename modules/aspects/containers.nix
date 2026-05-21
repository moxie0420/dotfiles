{
  den.aspects.containers = {
    nixos = {
      # enable nixos containers
      boot.enableContainers = true;

      security.unprivilegedUsernsClone = true;

      virtualisation.containers.enable = true;

      # Enable Podman for a container runtime
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      # Use docker as the backend for nix managed oci-containers
      virtualisation.oci-containers.backend = "podman";
    };

    provides.to-users = {user, ...}: {
      # Add the user to the docker group so it may access the socket.
      nixos.users.groups.podman.members = [user.userName];
    };
  };
}
