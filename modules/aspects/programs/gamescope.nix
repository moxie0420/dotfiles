{programs, ...}: {
  programs.gamescope = {
    nixos.programs = {
      gamescope = {
        args = [
          "--rt"
          "-W 1920"
          "-H 1080"
          "-b"
          "-f"
        ];

        capSysNice = true;
        enable = true;
      };

      steam.gamescopeSession.enable = true;
    };

    provides.to-hosts.includes = [
      programs.gamescope
    ];
  };
}
