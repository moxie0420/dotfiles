{
  den.aspects.containers = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = builtins.attrValues {
        inherit (pkgs) lazydocker;
      };

      security.unprivilegedUsernsClone = true;

      virtualisation.containers.enable = true;

      # Enable Docker for a runtime. I want to swith to podman but
      # I do not know how to migrate docker volumes to podman yet
      virtualisation.docker.enable = true;

      # Use docker as the backend for nix managed oci-containers
      virtualisation.oci-containers.backend = "docker";
    };

    provides.to-users = {user, ...}: {
      # Add the user to the docker group so it may access the socket.
      nixos.users.groups.docker.members = [user];
    };
  };
}
