{
  system.hostfile = {
    host-addrs = {
      config,
      host,
      ...
    }: {
      addr = host.address;
      hostname = config.networking.hostName;
    };

    nixos = {
      lib,
      host-addrs,
      ...
    }: {
      networking.extraHosts =
        lib.concatMapStringsSep "\n" (
          entry: "${entry.addr} ${entry.hostname}"
        )
        host-addrs;
    };
  };
}
