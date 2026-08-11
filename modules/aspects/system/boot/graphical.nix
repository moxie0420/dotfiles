{system, ...}: {
  system.boot.graphical = {
    includes = [system.boot.silent];

    nixos = {
      boot.plymouth = {
        enable = true;
      };
    };
  };
}
