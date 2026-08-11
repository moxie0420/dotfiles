{den, ...}: {
  den.aspects.containers = {
    internal-nat = {
      nixos.networking.nat = {
        enable = true;
        # Lazy IPv6 connectivity for the container
        enableIPv6 = true;
        externalInterface = "ens3";
        # Use "ve-*" when using nftables instead of iptables
        internalInterfaces = ["ve-+"];
      };
    };

    nixos = {
      # enable nixos containers
      boot.enableContainers = true;
      security.unprivilegedUsernsClone = true;

      virtualisation = {
        containers.enable = true;
        # Use docker as the backend for nix managed oci-containers
        oci-containers.backend = "podman";

        # Enable Podman for a container runtime
        podman = {
          defaultNetwork.settings.dns_enabled = true;
          dockerCompat = true;
          enable = true;
        };
      };
    };

    nvidia = {
      includes = [
        den.aspects.containers
      ];
    };

    provides.to-users = {user, ...}: {
      # Add the user to the docker group so it may access the socket.
      nixos.users.groups.podman.members = [user.userName];
    };
  };
}
