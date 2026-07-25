{
  programs.ssh = {
    homeManager.programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        "*" = {
          addKeysToAgent = "no";
          compression = false;
          controlMaster = "no";
          controlPath = "~/.ssh/master-%r@%n:%p";
          controlPersist = "no";
          forwardAgent = false;
          hashKnownHosts = false;
          serverAliveCountMax = 3;
          serverAliveInterval = 0;
          userKnownHostsFile = "~/.ssh/known_hosts";
        };

        "192.168.50.138" = {
          HostName = "192.168.50.138";
          IdentityFile = "~/.ssh/id_ed25519";
        };
      };
    };
  };
}
