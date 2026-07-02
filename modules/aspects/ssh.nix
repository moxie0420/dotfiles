{
  den.aspects.ssh = {
    homeManager.programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        "*" = {
          forwardAgent = false;
          addKeysToAgent = "no";
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
        };

        "192.168.50.163" = {
          HostName = "192.168.50.163";
          User = "root";
          IdentityFile = "~/.ssh/id_ed25519";
        };
      };
    };
  };
}
