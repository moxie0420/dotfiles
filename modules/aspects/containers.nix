{den, ...}: {
  den.aspects.containers = {
    internal-nat = {
      nixos.networking.nat = {
        enable = true;
        # Use "ve-*" when using nftables instead of iptables
        internalInterfaces = ["ve-+"];
        externalInterface = "ens3";
        # Lazy IPv6 connectivity for the container
        enableIPv6 = true;
      };
    };

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

    nvidia = {
      includes = [
        den.aspects.containers
      ];
      nixos = {
        hardware.nvidia-container-toolkit.enable = true;
      };
    };
  };
}
